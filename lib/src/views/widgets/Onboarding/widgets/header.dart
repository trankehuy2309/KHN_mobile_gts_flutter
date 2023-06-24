import 'dart:math';

import 'package:flutter/material.dart';

import '../constant.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    Key? key,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Logo(
          color: kWhite,
          size: 32.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kWhite,
                ),
          ),
        ),
      ],
    );
  }
}

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: Icon(
        Icons.format_bold,
        color: color,
        size: size,
      ),
    );
  }
}
