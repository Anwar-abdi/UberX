import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/images.dart';
import '../controller/onboarding_controller.dart';
import '../widget/custom_button.dart';
import '../widget/label_text.dart';
import '../widget/onboarding_dot.dart';
import '../widget/onboarding_header.dart';
import '../widget/onboarding_text.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              Column(
                children: [
                  OnboardingHeader(
                    image: Images.onePlus1,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  OnboardingText(
                    mainText: 'Getting Started With\n',
                    mainColor: Colors.black,
                    emphasizedText: 'Easy Rental',
                    emphasizedColor: Colors.blue,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  LabelText(
                    screenHeight: screenHeight,
                    text:
                        'Start your hassle-free car rental journey today with EasyRental—simple, fast, and reliable.',
                  ),
                ],
              ),
              Column(
                children: [
                  OnboardingHeader(
                    image: Images.onePlus2,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  OnboardingText(
                    mainText: 'Add to Favorites: ',
                    mainColor: Colors.blue,
                    emphasizedText: 'Keep\nYour Dream Car Close',
                    emphasizedColor: Colors.black,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  LabelText(
                    screenHeight: screenHeight,
                    text:
                        'Effortlessly save your dream cars for instant access anytime, anywhere.',
                  ),
                ],
              ),
              Column(
                children: [
                  OnboardingHeader(
                    image: Images.onePlus3,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  OnboardingText(
                    mainText: 'Track Your Rental: ',
                    mainColor: Colors.blue,
                    emphasizedText: 'Stay In\nControl Of Your Journey',
                    emphasizedColor: Colors.black,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  LabelText(
                    screenHeight: screenHeight,
                    text:
                        'Enjoy peace of mind with real-time rental tracking and stay in control.',
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 5,
            child: TextButton(
              onPressed: () => controller.skipPage(),
              child: Text(
                'Skip'.toUpperCase(),
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.08,
            left: 0,
            right: 0,
            child: Center(
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  return Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          controller.currentIndex.value == 0
                              ? const SizedBox(width: 48)
                              : CustomButton(
                                  onTap: controller.previousPage,
                                  icon: Icons.arrow_back,
                                  size: screenHeight * 0.03,
                                ),
                          OnBoardingDotNavigation(),
                          CustomButton(
                            onTap: () => controller.nextPage(),
                            icon: Icons.arrow_forward,
                            size: screenHeight * 0.03,
                          ),
                        ],
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
