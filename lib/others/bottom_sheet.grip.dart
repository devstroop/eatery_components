import 'package:flutter/material.dart';

class BottomSheetGrip extends StatelessWidget {
  const BottomSheetGrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
        width: 60,
        height: 5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
          color: Color(0xFFBBBBBB),
        ));
  }
}
