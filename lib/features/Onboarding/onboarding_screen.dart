import 'package:barcodesearch/features/Onboarding/intro_screens.dart';
import 'package:barcodesearch/features/Onboarding/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<OnBoardingData> list = [
    OnBoardingData(
      image: Lottie.asset(
        'assets/lottie/animation1.json',
      ),
      desc: 'Sen de ürünlerin barkodunu bulurken zorlanıyor musun?',
    ),
    OnBoardingData(
      image: Lottie.asset(
        'assets/lottie/animation2.json',
      ),
      desc: 'Bu uygulama sayesinde, bir ürünün barkodunu hızlı ve kolay bir şekilde öğrenebilirsiniz.',
    ),
    OnBoardingData(
      image: Lottie.asset(
        'assets/lottie/animation3.json',
      ),
      desc: 'İstersen ürün adını yazıp barkodunu öğrenebilir veya ürün barkodunu okutup ürünün adını öğrenebilirsin.',
    ),
    OnBoardingData(
      image: Lottie.asset(
        'assets/lottie/animation4.json',
      ),
      desc: 'Hadi başlayalım ve ürün arama dünyasına adım atalım!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }
}
