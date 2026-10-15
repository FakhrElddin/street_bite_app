import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';

class ProfileAvatarImage extends StatelessWidget {
  final Uint8List? localBytes;
  final String? imageString;
  final double radius;

  const ProfileAvatarImage({
    super.key,
    this.localBytes,
    this.imageString,
    this.radius = 48,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (localBytes != null && localBytes!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: isDark ? AppColors.cardDark : Colors.grey.shade200,
        backgroundImage: MemoryImage(localBytes!),
      );
    }

    if (imageString != null && imageString!.isNotEmpty) {
      if (imageString!.startsWith('http://') ||
          imageString!.startsWith('https://')) {
        return CachedNetworkImage(
          imageUrl: imageString!,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => CircleAvatar(
            radius: radius,
            backgroundColor:
                isDark ? AppColors.cardDark : Colors.grey.shade200,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: radius,
            backgroundColor:
                isDark ? AppColors.cardDark : Colors.grey.shade200,
            child: Icon(
              Icons.person_rounded,
              size: radius * 1.1,
              color: isDark ? AppColors.greyColor : Colors.grey.shade400,
            ),
          ),
        );
      }

      try {
        final cleanBase64 = imageString!.contains(',')
            ? imageString!.split(',').last
            : imageString!;
        final decodedBytes = base64Decode(cleanBase64);
        return CircleAvatar(
          radius: radius,
          backgroundColor: isDark ? AppColors.cardDark : Colors.grey.shade200,
          backgroundImage: MemoryImage(decodedBytes),
        );
      } catch (_) {
        // Fallback on decode failure
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: isDark ? AppColors.cardDark : Colors.grey.shade200,
      child: Icon(
        Icons.person_rounded,
        size: radius * 1.1,
        color: isDark ? AppColors.greyColor : Colors.grey.shade400,
      ),
    );
  }
}
