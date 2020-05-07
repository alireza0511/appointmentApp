//
//  ui-constants.dart
//  JazzB
//
//  Created by Alireza Khakpour on 7/18/19.
//  Copyright © 2019 JazzB. All rights reserved.
//

import 'package:appointment_app/appointment/models/helper/enum-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UiConstants {
  static const TextStyle nameLblTextStyle =
      const TextStyle(fontSize: 20, color: Colors.blue);
  static const TextStyle subTitleLblTextStyle =
      const TextStyle(fontSize: 14, color: Colors.grey);
  static const TextStyle keyLblTextStyle =
      const TextStyle(fontSize: 20, color: Colors.black54);
  static const TextStyle valueLblTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black87);
  static const TextStyle flatBtnTextStyle =
      const TextStyle(fontSize: 16, color: Colors.blue);
  static const TextStyle chipTextStyle =
      const TextStyle(fontSize: 18, color: ColorConstants.chipText);
  static const TextStyle tabLblTextStyle =
      const TextStyle(fontSize: 18, color: ColorConstants.tabText);
  static const TextStyle rateLblTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: Color(0xffff5722),
  );
  static const TextStyle distLblTextStyleSmall = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white);
  static const TextStyle distLblTextStyleBig = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  static const EdgeInsets paddingAll8EdgeIns = const EdgeInsets.all(8);

  static const SizedBox ver6SizedBox = const SizedBox(
    height: 6,
  );
  static const SizedBox ver12SizedBox = const SizedBox(
    height: 12,
  );

  static const SizedBox hor12SizedBox = const SizedBox(
    width: 12,
  );

  static const double goldenRectRatio = 1.618;
  static const double catRectRatio = 1.2;
  static const double promoRatio = 1 / 2;

  static const Text powerByJazzb = const Text(
    'Powered by ©JazzB',
    style: TextStyle(
        fontSize: 12,
        color: ColorConstants.chipText,
        fontFamily: 'Courgette',
        fontWeight: FontWeight.bold),
  );

  static const Text mileTxtWidget = const Text(
    'Mile',
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xAAFFFFFF)),
  );

  static const Text noFilterResult = const Text(
    'No results found!\nPlease try another search.',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.white),
  );

  static const Text saveBtnTxt = const Text(
    'Save',
    style: tabLblTextStyle,
  );

  static OutlineButton outLineBtn({Function onPress, String btnName}) {
    return OutlineButton(
      textColor: Colors.blueAccent,
      splashColor: Colors.white,
      color: Colors.white,
      onPressed: onPress,
      child: 
      Text(btnName),
    );
  }

  static FlatButton flatBtn({Function onPress, String btnName}) {
    return FlatButton(
      
      textColor: Colors.white,
      splashColor: Colors.white,
      color: Colors.white,
      onPressed: onPress,
      child: 
      Text(btnName),
    );
  }

  static double getObjectHeight(BuildContext context, [UiType type]) {
    final height = MediaQuery.of(context).size.height;
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;
    final width = MediaQuery.of(context).size.width;
    if (width <= 360) {
      switch (type) {
        default:
          return height;
      }
    } else if (width > 360 && width < 420) {
      switch (type) {
        default:
          return height;
      }
    } else {
      switch (type) {
        default:
          return height;
      }
    }
  }

  static double getObjectWidth(BuildContext context, [UiType type]) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 360) {
      switch (type) {
        default:
          return width;
      }
    } else if (width > 360 && width < 420) {
      switch (type) {
        default:
          return width;
      }
    } else {
      switch (type) {
        default:
          return width;
      }
    }
  }
}

class ColorConstants {
  static const Color primarySwatch = Colors.deepOrange;

  static const Color accentColor = Colors.blueAccent;
  static const Color buttonColor = Colors.blueAccent;

  static const Brightness brightness = Brightness.light;

  // consumer side colors
  // static const Color backgroundColor = Color(0xff1E1E1E);
  static const Color backgroundColor = Color(0xffF3F3F4);

  static const Color border = Color(0xffff5722);
  // static const Color border = Color(0xff00AEEF);

  // static const Color header = Color(0xFF0C8E8E);
  static const Color header = Color(0xff00AEEF);

  static const Color text = Colors.black87;
  static const Color textBackground = Colors.black26;

  // static const Color chipBackground = Color(0xff0C8E8E);
  static const Color chipBackground = Color(0xff00AEEF);

  static const Color chipBorder = Colors.white;
  static const Color chipText = Colors.white;

  static const Color cardBackground = Color(0xFFF5F5F5);

  static const Color tabText = Colors.white;
  static const Color tabIndicator = Color(0xffff5722);
  static const Color unselectedLabel = Colors.grey;

  // static const Color shapeOnBranch = Color(0xCC007066);
  static const Color shapeOnBranch = Color(0xCC00AEEF);

  static const Color rate = Colors.yellow; //Color(0xffffbf00);

  static const Color themeColorLight = Color(0x770C8E8E);
}

class ColorConstantsAdmin {
  static const Color primarySwatch = Colors.blueAccent;
  static const Color accentColor = Colors.blueAccent;
  static const Color buttonColor = Colors.blueAccent;

  static const Color chipBackground = Colors.blueAccent;
}
