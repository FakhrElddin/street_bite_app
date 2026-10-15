import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/config/app_theme.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_validators.dart';
import 'package:street_bite_app/core/utils/custom_app_dialog.dart';
import 'package:street_bite_app/core/widgets/custom_button.dart';
import 'package:street_bite_app/core/widgets/custom_text_form_field.dart';
import 'package:street_bite_app/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_footer_section.dart';
import 'package:street_bite_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:street_bite_app/features/main_navigation/presentation/screens/main_navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
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
                          controller: nameController,
                          labelText: 'Name',
                          hintText: 'Enter Your Name',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidators.validateUsername,
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidators.validatePassword,
                        ),
                        SizedBox(height: 16),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Your Password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return AppValidators.validateConfirmPassword(
                              value,
                              confirmPasswordController.text,
                            );
                          },
                        ),
                        SizedBox(height: 24),
                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterError) {
                              CustomAppDialog.showError(
                                context: context,
                                title: 'Error',
                                description: state.failure.errorMessage,
                              );
                            } else if (state is RegisterSuccess) {
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
                            if (state is RegisterLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.greenLightColor,
                                ),
                              );
                            }
                            return CustomTextButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).registerUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
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
        ),
      ),
    );
  }
}
