import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/widget/loader.dart';
import '../../../constant/validation_utils.dart';
import '../controller/register_controller.dart';
import '../widget/auth_field.dart';
import '../widget/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.vertical,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Create Account',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Fill your information below or register \nwith your social account',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  AuthField(
                    controller: controller.nameController,
                    hintText: 'Name',
                    validator: ValidationUtils.validateName,
                  ),
                  SizedBox(height: screenHeight * 0.023),
                  AuthField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    validator: ValidationUtils.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight * 0.023),
                  Obx(
                    () => AuthField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      obscureText: controller.isPasswordObscure.value,
                      validator: ValidationUtils.validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                      toggleVisibility: controller.togglePasswordVisibility,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.023),
                  AuthField(
                    controller: controller.phoneController,
                    hintText: 'Phone Number',
                    textInputAction: TextInputAction.done,
                    validator: ValidationUtils.validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Obx(() => controller.isLoading.value
                      ? Loader()
                      : CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            controller.registerUser();
                          },
                        )),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
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
