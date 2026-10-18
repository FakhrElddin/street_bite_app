import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';

/// Model representing a vendor location on the map.
class VendorLocation {
  final String id;
  final String name;
  final String city;
  final String cuisineType;
  final double rating;
  final LatLng location;

  const VendorLocation({
    required this.id,
    required this.name,
    required this.city,
    required this.cuisineType,
    required this.rating,
    required this.location,
  });
}

class VendorMapScreen extends StatefulWidget {
  const VendorMapScreen({super.key});

  @override
  State<VendorMapScreen> createState() => _VendorMapScreenState();
}

class _VendorMapScreenState extends State<VendorMapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _errorMessage;

  // Default fallback location (Cairo)
  static const LatLng _defaultLocation = LatLng(30.0444, 31.2357);
  LatLng _currentLocation = _defaultLocation;

  // Hardcoded vendor locations across different cities
  static const List<VendorLocation> _hardcodedVendors = [
    VendorLocation(
      id: 'vendor_cairo',
      name: 'El Prince',
      city: 'Cairo',
      cuisineType: 'Egyptian Grill & Liver',
      rating: 4.8,
      location: LatLng(30.0719, 31.2568),
    ),
    VendorLocation(
      id: 'vendor_alex',
      name: 'Fish Market',
      city: 'Alexandria',
      cuisineType: 'Fresh Seafood',
      rating: 4.7,
      location: LatLng(31.2089, 29.8943),
    ),
    VendorLocation(
      id: 'vendor_giza',
      name: 'Zooba',
      city: 'Giza',
      cuisineType: 'Gourmet Street Food',
      rating: 4.6,
      location: LatLng(29.9870, 31.2118),
    ),
    VendorLocation(
      id: 'vendor_mansoura',
      name: 'Abo Anas',
      city: 'Mansoura',
      cuisineType: 'Syrian & Shawarma',
      rating: 4.5,
      location: LatLng(31.0409, 31.3785),
    ),
    VendorLocation(
      id: 'vendor_luxor',
      name: 'Sofra Restaurant',
      city: 'Luxor',
      cuisineType: 'Traditional Egyptian',
      rating: 4.9,
      location: LatLng(25.6872, 32.6396),
    ),
    VendorLocation(
      id: 'vendor_aswan',
      name: 'El Dokka',
      city: 'Aswan',
      cuisineType: 'Nubian & Egyptian',
      rating: 4.7,
      location: LatLng(24.0889, 32.8998),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initMapAndLoadVendors();
  }

  /// Requests location permission, detects user position, and loads vendor markers.
  Future<void> _initMapAndLoadVendors() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Step A: Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permissions are denied.';
            _isLoading = false;
          });
          _createVendorMarkers();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
              'Location permissions are permanently denied, please enable them from settings.';
          _isLoading = false;
        });
        _createVendorMarkers();
        return;
      }

      // Step B: Get the current device GPS position
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      _currentLocation = LatLng(position.latitude, position.longitude);

      // Step C: Build markers for hardcoded vendors
      _createVendorMarkers();

      // Step D: Animate camera to user's position
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation, 12.0),
        );
      }
    } catch (e) {
      // Even if location fails, still populate vendor markers
      _createVendorMarkers();
      setState(() {
        _errorMessage = 'Failed to get current location: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Builds markers for all vendors showing name, cuisine type, and rating in InfoWindow.
  void _createVendorMarkers() {
    final Set<Marker> newMarkers = {};

    for (final vendor in _hardcodedVendors) {
      newMarkers.add(
        Marker(
          markerId: MarkerId(vendor.id),
          position: vendor.location,
          infoWindow: InfoWindow(
            title: vendor.name,
            snippet: '${vendor.cuisineType} • ⭐ ${vendor.rating}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }

    _markers.clear();
    _markers.addAll(newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nearby Vendors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildBody(isDark),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.primaryColor),
            const SizedBox(height: 16),
            Text(
              'Locating nearby vendors...',
              style: TextStyle(
                fontSize: 15,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null && _markers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_off_rounded,
                size: 64,
                color: AppColors.errorColor,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _initMapAndLoadVendors,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 11.0,
          ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
          },
        ),

        // Floating Action Button to re-center on my location
        Positioned(
          bottom: 24,
          right: 16,
          child: FloatingActionButton(
            heroTag: 'vendor_map_my_location_btn',
            backgroundColor: isDark ? AppColors.cardDark : Colors.white,
            foregroundColor: AppColors.primaryColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              if (_mapController != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(_currentLocation, 14.5),
                );
              }
            },
            child: const Icon(Icons.my_location_rounded),
          ),
        ),
      ],
    );
  }
}
