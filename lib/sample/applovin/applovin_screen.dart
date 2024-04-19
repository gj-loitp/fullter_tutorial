import 'dart:io';
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/core/base_stateful_state.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/url_launcher_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';

/**
 * Created by Loitp on 05,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */

enum AdLoadState { notLoaded, loading, loaded }

const String sdkKey = "e75FnQfS9XTTqM1Kne69U7PW_MBgAnGQTFvtwVVui6kRPKs5L7ws9twr5IQWwVfzPKZ5pF2IfDa7lguMgGlCyt";
final String _interstitialAdUnitId = Platform.isAndroid ? "~" : "IOS_INTER_AD_UNIT_ID";
final String _bannerAdUnitId = Platform.isAndroid ? "~" : "IOS_BANNER_AD_UNIT_ID";
var _listMyDevice = [
  "eeaaab5a1f0cf524", //poco f3
  "f2b945dfa5e953cf", //mi pad 5
  "05f26989e8ce5d06", //vsmart aris
  "b09ab0a421fa04a4", //samsung a50s
];

String getInterstitialAdUnitId() {
  debugPrint("roy93~ getInterstitialAdUnitId deviceId $deviceId");
  if (kDebugMode || _listMyDevice.contains(deviceId)) {
    return "${_interstitialAdUnitId}_debug";
  } else {
    return _interstitialAdUnitId;
  }
}

String getBannerAdUnitId() {
  debugPrint("roy93~ getBannerAdUnitId deviceId $deviceId");
  if (kDebugMode || _listMyDevice.contains(deviceId)) {
    return "${_bannerAdUnitId}_debug";
  } else {
    return _bannerAdUnitId;
  }
}

String? deviceId;
var _isInitialized = false;
var _interstitialLoadState = AdLoadState.notLoaded;
var _interstitialRetryAttempt = 0;
var _isProgrammaticBannerCreated = false;
var _isProgrammaticBannerShowing = false;
var _isWidgetBannerShowing = false;

var _statusText = "";

class ApplovinScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplovinScreenState();
  }
}

class _ApplovinScreenState extends BaseStatefulState<ApplovinScreen> {
  @override
  void initState() {
    super.initState();
    initializePlugin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "ApplovinScreen",
        () {
          Get.back();
        },
        () {
          UrlLauncherUtils.launchInBrowser("https://pub.dev/packages/applovin_max");
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            '$_statusText\n',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),

          //Mediation Debugger
          ElevatedButton(
            onPressed: _isInitialized
                ? () {
                    if (kDebugMode) {
                      AppLovinMAX.showMediationDebugger();
                    } else {
                      showSnackBarFull("Applovin", "Only available in debug mode");
                    }
                  }
                : null,
            child: const Text("Mediation Debugger"),
          ),

          //Interstitial
          ElevatedButton(
            onPressed: () {
              void showInter() async {
                bool isReady = (await AppLovinMAX.isInterstitialReady(getInterstitialAdUnitId()))!;
                if (isReady) {
                  AppLovinMAX.showInterstitial(getInterstitialAdUnitId());
                } else {
                  logStatus('Loading interstitial ad...');
                  _interstitialLoadState = AdLoadState.loading;
                  AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
                }
              }

              if (_isInitialized && _interstitialLoadState != AdLoadState.loading) {
                showInter();
              }
            },
            child: Text(getInterstitialButtonTitle()),
          ),
          ElevatedButton(
            onPressed: (_isInitialized && !_isWidgetBannerShowing)
                ? () async {
                    if (_isProgrammaticBannerShowing) {
                      AppLovinMAX.hideBanner(getBannerAdUnitId());
                    } else {
                      if (!_isProgrammaticBannerCreated) {
                        //
                        // Programmatic banner creation - banners are automatically sized to 320x50 on phones and 728x90 on tablets
                        //
                        AppLovinMAX.createBanner(getBannerAdUnitId(), AdViewPosition.bottomCenter);

                        // Set banner background color to black - PLEASE USE HEX STRINGS ONLY
                        AppLovinMAX.setBannerBackgroundColor(getBannerAdUnitId(), '#ff0000');

                        _isProgrammaticBannerCreated = true;
                      }

                      AppLovinMAX.showBanner(getBannerAdUnitId());
                    }

                    setState(() {
                      _isProgrammaticBannerShowing = !_isProgrammaticBannerShowing;
                    });
                  }
                : null,
            child: Text(getProgrammaticBannerButtonTitle()),
          ),

          //widget banner
          ElevatedButton(
            onPressed: (_isInitialized && !_isProgrammaticBannerShowing)
                ? () async {
                    setState(() {
                      _isWidgetBannerShowing = !_isWidgetBannerShowing;
                    });
                  }
                : null,
            child: Text(getWidgetBannerButtonTitle()),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
                  child: Text(
                    """If not for you, I wouldn’t know
What true love really meant.
I’d never feel this inner peace;
I couldn’t be content.

If not for you, I’d never have
The pleasures of romance.
I’d miss the bliss, the craziness,
Of love’s sweet, silly dance.

I have to feel your tender touch;
I have to hear your voice;
No other one could take your place;
You’re it; I have no choice.

If not for you, I’d be adrift;
I don’t know what I’d do;
I’d be searching for my other half,
Incomplete, if not for you.""",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isWidgetBannerShowing)
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(top: DimenConstants.marginPaddingSmall),
              child: MaxAdView(
                adUnitId: getBannerAdUnitId(),
                adFormat: AdFormat.banner,
                listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                  logStatus('Banner widget ad loaded from ${ad.networkName}');
                }, onAdLoadFailedCallback: (adUnitId, error) {
                  logStatus(
                      'Banner widget ad failed to load with error code ${error.code} and message: ${error.message}');
                }, onAdClickedCallback: (ad) {
                  logStatus('Banner widget ad clicked');
                }, onAdExpandedCallback: (ad) {
                  logStatus('Banner widget ad expanded');
                }, onAdCollapsedCallback: (ad) {
                  logStatus('Banner widget ad collapsed');
                }, onAdRevenuePaidCallback: (ad) {
                  logStatus('Banner widget ad revenue paid: ${ad.revenue}');
                }),
              ),
            ),
        ],
      ),
    );
  }

  // NOTE: Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");

    var isInitialized = await AppLovinMAX.isInitialized();
    logStatus("isInitialized $isInitialized");
    if (isInitialized == true) {
      _isInitialized = true;
      attachAdListeners();
    } else {
      deviceId = await PlatformDeviceId.getDeviceId;
      var configuration = await AppLovinMAX.initialize(sdkKey);
      if (configuration != null) {
        _isInitialized = true;
        logStatus("SDK Initialized: $configuration");
        attachAdListeners();
      }
    }
  }

  void attachAdListeners() {
    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        _interstitialLoadState = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        logStatus('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        logStatus('Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
        });
      },
      onAdDisplayedCallback: (ad) {
        logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        _interstitialLoadState = AdLoadState.notLoaded;
        logStatus('Interstitial ad failed to display with code ${error.code} and message ${error.message}');
      },
      onAdClickedCallback: (ad) {
        logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        _interstitialLoadState = AdLoadState.notLoaded;
        logStatus('Interstitial ad hidden');
      },
      onAdRevenuePaidCallback: (ad) {
        logStatus('Interstitial ad revenue paid: ${ad.revenue}');
      },
    ));

    /// Banner Ad Listeners
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('Banner ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus('Banner ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('Banner ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Banner ad revenue paid: ${ad.revenue}');
    }));
  }

  String getInterstitialButtonTitle() {
    if (_interstitialLoadState == AdLoadState.notLoaded) {
      return "Load Interstitial";
    } else if (_interstitialLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Interstitial"; // adLoadState.loaded
    }
  }

  String getProgrammaticBannerButtonTitle() {
    return _isProgrammaticBannerShowing ? 'Hide Programmatic Banner' : 'Show Programmatic Banner';
  }

  String getWidgetBannerButtonTitle() {
    return _isWidgetBannerShowing ? 'Hide Widget Banner' : 'Show Widget Banner';
  }

  void logStatus(String status) {
    debugPrint("roy93~ $status");

    setState(() {
      _statusText = status;
    });
  }
}
