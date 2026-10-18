import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth;

  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      if (!canCheck && !isDeviceSupported) {
        return false;
      }
      final availableBiometrics = await _auth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({
    String localizedReason = 'Please authenticate to show your profile info',
    bool biometricOnly = true,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: biometricOnly,
      );
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
