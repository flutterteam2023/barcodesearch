import 'package:barcodesearch/exceptions/mediaquery.dart';

import 'package:flutter/material.dart';

void showCustomModelBottomSheet(BuildContext context, Widget body, {bool? isScrollControlled}) {
  Navigator.of(context).canPop();

  showModalBottomSheet<Widget>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    context: context,
    isScrollControlled: isScrollControlled ?? true,
    builder: (context) => Container(
      height: context.height - context.safeTop - 70,
      margin: EdgeInsets.only(
        top: context.safeTop,
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            width: context.width * .15,
            margin: const EdgeInsets.only(
              bottom: 18,
              top: 18,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Colors.grey[400],
            ),
          ),
          Expanded(child: body),
        ],
      ),
    ),
  );
}
