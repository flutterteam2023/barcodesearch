// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OnBoardingData extends StatefulWidget {
  const OnBoardingData({
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
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 300,
            width: 300,
            child: image,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
