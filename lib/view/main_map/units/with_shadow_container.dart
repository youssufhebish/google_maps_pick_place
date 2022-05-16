import 'dart:ui';
import 'package:flutter/material.dart';

Widget withShadowDecoration(Widget child, BuildContext context) => ClipRRect(
  borderRadius: BorderRadius.circular(50.0),
  child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness ==
                Brightness.light
                ? Colors.white.withOpacity(0.25)
                : Colors.black.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
);