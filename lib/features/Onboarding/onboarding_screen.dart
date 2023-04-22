import 'package:barcodesearch/common_widgets/onboarding_widget.dart';
import 'package:barcodesearch/features/Onboarding/intro_screens.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnBoardingData> list = [
    OnBoardingData(
      image: Lottie.network(
        'https://assets10.lottiefiles.com/packages/lf20_oibkdzf3.json',
      ),
      desc: 'Sen de ürünlerin barkodunu bulurken zorlanıyor musun?',
    ),
    OnBoardingData(
      image: Lottie.network(
        'https://assets6.lottiefiles.com/packages/lf20_zzbz9na6.json',
      ),
      desc:
          'Bu uygulama sayesinde, bir ürünün barkodunu hızlı ve kolay bir şekilde öğrenebilirsiniz.',
    ),
    OnBoardingData(
      image: Lottie.network(
        'https://assets5.lottiefiles.com/packages/lf20_ayrV44lF4f.json',
      ),
      desc:
          'İstersen ürün adını yazıp barkodunu öğrenebilir veya ürün barkodunu okutup ürünün adını öğrenebilirsin.',
    ),
    OnBoardingData(
      image: Lottie.network(
        'https://assets1.lottiefiles.com/packages/lf20_ER8E6HKqBl.json',
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
