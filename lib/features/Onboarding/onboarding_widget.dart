// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnBoardingData extends StatefulWidget {
   OnBoardingData({
    required this.image,
    required this.desc,
    super.key,
  });
  final Widget image;
  final String desc;
  @override
  State<OnBoardingData> createState() => _OnBoardingDataState();
}

class _OnBoardingDataState extends State<OnBoardingData> {
  @override
  Widget build(BuildContext context) {
    final image = widget.image;

    final desc = widget.desc;
    return Container(

      child: Column(

        children: <Widget>[
          SizedBox(
            height: 45.h,
            width: 45.w,
            child: image,
          ),
            Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

        ],
      ),
    );
  }
}
