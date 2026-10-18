import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_avatar_image.dart';
import 'package:street_bite_app/generated/l10n.dart';

class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? email;
  final String? profileImage;
  final Uint8List? localAvatarBytes;
  final bool isUploading;
  final VoidCallback onEditPhotoTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.localAvatarBytes,
    required this.isUploading,
    required this.onEditPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.5,
                ),
              ),
              child: ProfileAvatarImage(
                localBytes: localAvatarBytes,
                imageString: profileImage,
                radius: 50,
              ),
            ),
            if (isUploading)
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 3,
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: isUploading ? null : onEditPhotoTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? AppColors.backgroundColorDark
                          : Colors.white,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name != null && name!.isNotEmpty ? name! : S.of(context).guestUser,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.whiteColor : AppColors.blackColor,
          ),
        ),
        if (email != null && email!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            email!,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ],
    );
  }
}
