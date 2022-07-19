import 'package:flutter/material.dart';

class BlankSpace extends StatelessWidget {
  const BlankSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30,
        height: 30,
        color: Colors.white,
        //child: Text('.'),
      ),
    );
  }
}
