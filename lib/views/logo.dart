import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'icon',
      child: SvgPicture.asset(
        'assets/moments.svg',
        width: 130,
      ),
    );;
  }

}