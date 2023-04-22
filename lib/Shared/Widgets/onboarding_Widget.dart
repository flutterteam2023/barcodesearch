import 'package:flutter/material.dart';

class OnbordingData extends StatefulWidget {
  const OnbordingData({
    required this.image,
    required this.desc,
    super.key,
  });
  final Widget image;

  final String desc;

  @override
  _OnbordingDataState createState() =>
      _OnbordingDataState(this.image, this.desc);
}

class _OnbordingDataState extends State<OnbordingData> {
  _OnbordingDataState(this.image, this.desc);
  final Widget image;

  final String desc;

  @override
  Widget build(BuildContext context) {
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
