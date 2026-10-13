import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/widgets/custom_button.dart';
import 'package:street_bite_app/core/widgets/custom_text_form_field.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_footer_section.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(
              backgroundImageHeight: screenHeight * 0.5,
              logoHeight: screenHeight * 0.157,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Food and groceries delivered to you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
                  SizedBox(height: 24),
                  CustomTextButton(text: 'Log In', onTap: () {}),
                  SizedBox(height: 24),
                  AuthFooterSection(
                    questionText: "Don't have account? ",
                    actionText: 'SIGN UP',
                    onActionTap: () {},
                  ),
                  SafeArea(bottom: true, child: SizedBox.shrink()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
