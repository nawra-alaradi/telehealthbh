import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const kCircleAvatarChatbotCharacter =
    TextStyle(fontFamily: 'Judson', fontWeight: FontWeight.w700, fontSize: 25);
const kTypedMessageTextStyle =
    TextStyle(fontSize: 16, fontFamily: 'Judson', fontWeight: FontWeight.w400);

const kChatbotSenderNameTextStyle = TextStyle(
    fontFamily: 'Works Sans', fontWeight: FontWeight.w300, fontSize: 13);

const kPaymentSummaryTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Work Sans',
    color: Colors.black);

const kDropdownItemTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Work Sans',
    fontWeight: FontWeight.w400,
    color: Colors.black);

const kDropdownHintTextStyle = TextStyle(
  fontFamily: 'Work Sans',
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

const kCardTextStyle = TextStyle(
  fontSize: 18, fontFamily: 'Work Sans',
  fontWeight: FontWeight.w300, //Work sans regular
  color: Colors.black,
);
const kBodyTextStyle = TextStyle(
  fontSize: 18, fontFamily: 'Work Sans',
  fontWeight: FontWeight.w400, //Work sans regular
  color: Colors.black,
);
const kCircleAvatarTextStyle = TextStyle(
  fontSize: 150, fontFamily: 'Work Sans',
  fontWeight: FontWeight.w600, //Work sans semi-bold
  color: Colors.white,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 16, fontFamily: 'Work Sans',
  fontWeight: FontWeight.w500, //Work sans medium
  color: Colors.white,
);
const ktextFieldHeader = TextStyle(
  fontSize: 16,
  fontFamily: 'Work Sans',
  fontWeight: FontWeight.w600, //Work sans semi-bold
  color: Color(0xFF030303),
);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    fontSize: 14,
    fontFamily: 'Work Sans',
    fontWeight: FontWeight.w400, //Work Sans light
    color: Color(0xFF9E9E9E),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF858684), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF858684), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

const kSmallText = TextStyle(
    color: Color(0xFF0D47A1),
    fontWeight: FontWeight.w600,
    fontFamily: 'Works Sans',
    fontSize: 14);

TextStyle kLargeButtonTextStyle = TextStyle(
    //changed from const to TextStyle due to opacity variation
    color: Color(0x00000000).withOpacity(0.8),
    fontSize: 18,
    fontFamily: 'Judson',
    fontWeight: FontWeight.w700);

const kErrorTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Work Sans');

const kSnackbarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Judson',
    fontWeight: FontWeight.w400);
