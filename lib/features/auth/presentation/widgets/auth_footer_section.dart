import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';

class AuthFooterSection extends StatelessWidget {
  const AuthFooterSection({
    super.key,
    required this.questionText,
    required this.actionText,
    this.onActionTap,
  });

  final String questionText;
  final String actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$questionText ",
        style: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 16,
          color: AppColors.whiteColor,
        ),
        children: [
          TextSpan(
            text: actionText.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onActionTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
