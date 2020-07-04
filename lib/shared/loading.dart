import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF383e56),
      child: Center(
        child: SpinKitDualRing(
          color: Color(0xFFddf3f5),
          size: 80.0,
        ),
      ),
    );
  }
}
