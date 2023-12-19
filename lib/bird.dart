import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: Image.asset('assets/bird.png'),
    );
  }
}
