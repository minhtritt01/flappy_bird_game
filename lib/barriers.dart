import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  const Barriers({Key? key, required this.size}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: size,
      decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 8.0, color: Colors.brown),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
