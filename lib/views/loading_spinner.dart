import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moments/style/style.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: primaryColor,
      lineWidth: 2,
      size: 48,
    );
  }
}