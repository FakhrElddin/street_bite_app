import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/config/app_theme.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_validators.dart';
import 'package:street_bite_app/core/utils/custom_app_dialog.dart';
import 'package:street_bite_app/core/widgets/custom_button.dart';
import 'package:street_bite_app/core/widgets/custom_text_form_field.dart';
import 'package:street_bite_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:street_bite_app/features/auth/presentation/screens/register_screen.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_footer_section.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:street_bite_app/features/main_navigation/presentation/screens/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Theme(
        data: AppTheme.authTheme,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: SingleChildScrollView(
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
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter Your Email',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidators.validateEmail,
                        ),
                        SizedBox(height: 16),
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidators.validate,
                        ),
                        SizedBox(height: 24),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginError) {
                              CustomAppDialog.showError(
                                context: context,
                                title: 'Error',
                                description: state.failure.errorMessage,
                              );
                            } else if (state is LoginSuccess) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainNavigationScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.greenLightColor,
                                ),
                              );
                            }
                            return CustomTextButton(
                              text: 'Log In',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } else {
                                  setState(() {
                                    autoValidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: 24),
                        AuthFooterSection(
                          questionText: "Don't have account? ",
                          actionText: 'SIGN UP',
                          onActionTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
