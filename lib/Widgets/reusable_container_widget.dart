import 'package:flutter/material.dart';

class ReusableContainerWidget extends StatelessWidget {
  const ReusableContainerWidget({Key? key}) : super(key: key);

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
        children: [
          // image, time and degree
        ],
      ),
    );
  }
}
