import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcodesearch/common_widgets/app_buttons.dart';
import 'package:barcodesearch/exceptions/mediaquery.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/features/Authentication/Widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Widgets/login.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';
import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void showDetailsSheet({
  required BuildContext context,
  required ProductModel product,
}) {
  const isActiveBlur = true;
  var blurText = MyUser().isNull()
      ? 'Barkodu görüntülemek için giriş yapmalısınız'
      : 'Barkodu görüntüle(-3 kredi)';
  showModalBottomSheet<Widget>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    context: context,
    builder: (context) {
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
                    Text(product.name ?? 'error'),
                    Bounceable(
                      onTap: () {
                        blurText = 'asdasd';
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
                                data: product.barcode ?? '12312312312',
                              ),
                            ),
                          ),
                          if (isActiveBlur)
                            ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(
                                  width: 80.w,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.5),
                                  ),
                                  child: Center(
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
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    AppButtons.roundedButton(
                      borderRadius: BorderRadius.circular(14),
                      backgroundColor: Colors.indigo,
                      text: 'Giriş Yap',
                      function: () async {
                        showCustomModelBottomSheet(context, LoginScreen());
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
}
