import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcodesearch/app_config.dart';
import 'package:barcodesearch/common_widgets/app_buttons.dart';
import 'package:barcodesearch/constants/authentication_constant.dart';
import 'package:barcodesearch/constants/searching_constants.dart';
import 'package:barcodesearch/exceptions/mediaquery.dart';
import 'package:barcodesearch/features/Ads/Controller/credit_manager.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/common_widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Widgets/login.dart';
import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:sizer/sizer.dart';

void showDetailsSheet({
  required BuildContext context,
  required ProductModel product,
}) {
  final searchingConstants = locator<SearchingConstants>();
  final isActiveBlur = ValueNotifier(true);
  showModalBottomSheet<Widget>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    context: context,
    builder: (context) {
      return MultiValueListenableBuilder(
        valueListenables: [MyUser(), isActiveBlur],
        builder: (context, s, ss) {
          final blurText = MyUser().isNull() ? searchingConstants.alertLogin : searchingConstants.barcodeCost;
          return Container(
            height: context.height - context.safeTop - 70,
            margin: EdgeInsets.only(
              top: context.safeTop,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 100.w * .15,
                  margin: const EdgeInsets.only(
                    bottom: 18,
                    top: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Text(product.name ?? 'null error'),
                        Bounceable(
                          onTap: () async {
                            if (!MyUser().isNull() && isActiveBlur.value == true && (MyUser().getCredit() ?? 0) >= APP_CONFIG.barcodeViewFee) {
                              await CreditManager().creditDiscrememnt(APP_CONFIG.barcodeViewFee).then((value) {
                                if (value == true) {
                                  isActiveBlur.value = false;
                                } else {
                                  /// kredi azaltma işlemi gerçekleşmediği için bulanıklık kaldırılmadı.
                                }
                              });
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                child: SizedBox(
                                  width: 80.w,
                                  height: 100,
                                  child: BarcodeWidget(
                                    barcode: Barcode.code128(),
                                    data: product.barcode ?? '',
                                  ),
                                ),
                              ),
                              if (isActiveBlur.value)
                                ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: MyUser().isNull() || isActiveBlur.value ? 4 : 0,
                                      sigmaY: MyUser().isNull() || isActiveBlur.value ? 4 : 0,
                                    ),
                                    child: SizedBox(
                                      width: 80.w,
                                      height: 100,
                                      child: MyUser().isNull() || isActiveBlur.value
                                          ? Center(
                                              child: Text(
                                                blurText,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  backgroundColor: Colors.indigo,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        if (MyUser().isNull())
                          AppButtons.roundedButton(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor: Colors.indigo,
                            text: StringConstants.logout,
                            function: () async {
                              showCustomModelBottomSheet(
                                context,
                                LoginScreen(),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
