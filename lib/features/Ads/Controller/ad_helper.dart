import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5712956083142342/4392716475';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5712956083142342/5622037660';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5712956083142342/1609327381';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5712956083142342/7565674724';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
