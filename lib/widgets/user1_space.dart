import 'package:flutter/material.dart';
class User1Space extends StatelessWidget {
  const User1Space({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30,
        height: 30,
        color: Colors.white,
        child: const Icon(Icons.circle_outlined, color: Colors.black)
      ),
    );
  }
}
