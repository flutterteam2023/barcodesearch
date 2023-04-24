import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Controller/ad_helper.dart';

class RewardAdsScreen extends StatefulWidget {
  const RewardAdsScreen({super.key});

  @override
  State<RewardAdsScreen> createState() => _RewardAdsScreenState();
}

class _RewardAdsScreenState extends State<RewardAdsScreen> {
  RewardedAd? _rewardedAd;
  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

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
  Widget? _buildFloatingActionButton() {
  // TODO: Return a FloatingActionButton if a rewarded ad is available
  return (_rewardedAd != null)
      ? FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Need a hint?'),
                  content: Text('Watch an Ad to get a hint!'),
                  actions: [
                    TextButton(
                      child: Text('cancel'.toUpperCase()),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('ok'.toUpperCase()),
                      onPressed: () {
                        Navigator.pop(context);
                        _rewardedAd?.show(
                          onUserEarnedReward: (_, reward) {
                            
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
          label: Text('Hint'),
          icon: Icon(Icons.card_giftcard),
        )
      : null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFloatingActionButton(),
    );
  }
}