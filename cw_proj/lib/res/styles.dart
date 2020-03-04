import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';
import 'dimens.dart';

const ZITI = 'ZCOOLXiaoWei';

class TextStyles {
  
  static const TextStyle textSize12 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp16,
  );
   static const TextStyle textSize18 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp18,
  );
  static const TextStyle textSize30 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp30,
  );
  static const TextStyle textBold14 = const TextStyle(
      fontFamily: ZITI,
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = const TextStyle(
      fontFamily: ZITI,
      fontSize: Dimens.font_sp16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = const TextStyle(
      fontFamily: ZITI,
      fontSize: 24.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = const TextStyle(
      fontFamily: ZITI,
      fontSize: 26.0,
      fontWeight: FontWeight.bold
  );
    static const TextStyle textBold40 = const TextStyle(
      fontFamily: ZITI,
      fontSize: 40.0,
      fontWeight: FontWeight.bold
  );
 
  static const TextStyle textGray14 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textDarkGray14 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

    static const TextStyle textWhite30 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp30,
    color: Colors.white,
  );
  
  static const TextStyle text = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colours.text,
    // https://github.com/flutter/flutter/issues/40248
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textDark = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text,
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textDark30 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp30,
    color: Colours.dark_text,
    textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textGray12 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
    fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp12,
    color: Colours.dark_text_gray,
    fontWeight: FontWeight.normal
  );
  
  static const TextStyle textHint14 = const TextStyle(
    fontFamily: ZITI,
    fontSize: Dimens.font_sp14,
    color: Colours.dark_unselected_item_color
  );
}