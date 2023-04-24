import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcodesearch/common_widgets/app_buttons.dart';
import 'package:barcodesearch/common_widgets/input_field.dart';
import 'package:barcodesearch/features/Ads/reward_ads_screen.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/features/Authentication/Widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Widgets/login.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';
import 'package:barcodesearch/features/Authentication/register_manager.dart';
import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Searching/Service/barcode_searching_service.dart';
import 'package:barcodesearch/features/Searching/Service/name_searching_service.dart';
import 'package:barcodesearch/features/Searching/Values/product_list.dart';
import 'package:barcodesearch/features/Searching/details_sheet.dart';
import 'package:barcodesearch/routing/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../Ads/Controller/ad_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  late TextEditingController searchController;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    _loadRewardedAd();

    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  ValueNotifier<String> searchValue = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Yeni Öneri',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(Iconsax.add_circle),
      ),
      body: ValueListenableBuilder(
        valueListenable: MyUser(),
        builder: (context, _, __) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 9,
                  left: 18,
                  right: 18,
                ),
                child: Column(
                  children: [
                    header(),
                    if (!MyUser().isNull()) const SizedBox(height: 18),
                    if (!MyUser().isNull())
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hoşgeldin ${MyUser().getName()}',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              const Text('Çıkış Yap'),
                              IconButton(
                                onPressed: () async {
                                  await LoginManager().signOut();
                                },
                                icon: const Icon(
                                  Iconsax.login,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 60,
                      child: InputField(
                        hintText: 'Ürün ismi veya barkod ara',
                        suffixIcon: const Icon(
                          Iconsax.scan_barcode,
                          size: 26,
                        ),
                        onChanged: (value) {
                          searchValue.value = value;
                        },
                        controller: searchController,
                      ),
                    ),
                    const SizedBox(height: 18),
/*                     ElevatedButton(
                      onPressed: () {
                        context.pushNamed(APP_PAGE.onboarding.toName);
                      },
                      child: const Text('Go Onboarding screens'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDetailsSheet(
                          context: context,
                          product: ProductModel(),
                        );
                      },
                      child: const Text('Show Modal Bottom Sheet'),
                    ), */
                    SizedBox(
                      height: 60,
                      child: ValueListenableBuilder(
                        valueListenable: searchValue,
                        builder: (context, _, __) {
                          return AppButtons.roundedButton(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor: searchController.text.isNotEmpty
                                ? Colors.indigo
                                : const Color(0xff94959b),
                            iconData: Icons.search,
                            function: () async {
                              if (searchController.text.isNotEmpty) {
                                ProductList().reset();
                                BarcodeSearchingService.isLastPage = false;
                                BarcodeSearchingService.lastDocument = null;
                                NameSearchingService.isLastPage = false;
                                NameSearchingService.lastDocument = null;
                                await BarcodeSearchingService()
                                    .searchInitiliaze(
                                  text: searchController.text,
                                );
                                await NameSearchingService()
                                    .searchInitiliaze(
                                  text: searchController.text,
                                )
                                    .then((value) {
                                  context.pushNamed(
                                    APP_PAGE.results.toName,
                                    queryParams: {
                                      'searchedText': searchController.text,
                                    },
                                  );
                                });
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    if (_bannerAd != null)
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget header() {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Bounceable(
            onTap: () {
              _rewardedAd?.show(
                onUserEarnedReward: (_, reward) {
                  RegisterManager().credit.value =  RegisterManager().credit.value + (11-reward.amount.toInt());

                },
              );
            },
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.play_circle,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'İzle',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'BARKOD ARAMA',
                style: GoogleFonts.libreBarcode128Text(
                  color: Colors.grey[850],
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Bounceable(
            onTap: () {
              if (FirebaseAuth.instance.currentUser == null) {
                showCustomModelBottomSheet(context, LoginScreen());
              } else {}
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FirebaseAuth.instance.currentUser == null
                  ? const Icon(
                      Iconsax.user,
                      color: Colors.white,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Kredi',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${RegisterManager().credit.value}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
