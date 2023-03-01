import 'package:flutter/material.dart';

class ReusableContainerWidget extends StatelessWidget {
  String simpleText;
  String tempText;
  String img;
  ReusableContainerWidget(
      {required this.img, required this.tempText, required this.simpleText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff5c3db4), Color(0xff3e238e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // image, time and degree
          Image(
            image: NetworkImage(img),
            height: 50,
            width: 50,
          ),
          Text(
            tempText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            simpleText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
