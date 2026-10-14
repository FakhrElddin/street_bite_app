import 'package:flutter/material.dart';
import 'package:street_bite_app/core/config/app_theme.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/widgets/custom_button.dart';
import 'package:street_bite_app/core/widgets/custom_text_form_field.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_footer_section.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Theme(
      data: AppTheme.authTheme,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(
              backgroundImageHeight: screenHeight * 0.4,
              logoHeight: screenHeight * 0.15,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Your favorite street bites and essentials",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Your Password',
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  CustomTextButton(text: 'Sign Up', onTap: () {}),
                  SizedBox(height: 24),
                  AuthFooterSection(
                    questionText: "have account? ",
                    actionText: 'LOG IN',
                    onActionTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
