

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnbordingData extends StatefulWidget {
  final image;

  final desc;

  OnbordingData({this.image, this.desc});

  @override
  _OnbordingDataState createState() =>
      _OnbordingDataState(this.image, this.desc);
}

class _OnbordingDataState extends State<OnbordingData> {
  final image;

  final desc;
  _OnbordingDataState(this.image, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height:20.w,
            width:30.h,
            child: image,
          ),


          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}