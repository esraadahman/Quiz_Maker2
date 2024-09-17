import 'package:flutter/material.dart';
import 'package:quiz_maker2/color.dart';

import '../screens/profile.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 22
        ),
        children: <TextSpan>[
          TextSpan(text: 'Quiz', style: TextStyle(fontWeight: FontWeight.w600
              , color: text_color)),
          TextSpan(text: 'App', style: TextStyle(fontWeight: FontWeight.w600
              , color: buttomcolor)),
        ],
      ),
    );
  }
}