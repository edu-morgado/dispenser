import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget pageTitleStyle(String title) {
  return AutoSizeText(
    title,
    maxLines: 1,
    style: TextStyle(
      fontSize: 25,
    ),
  );
}

Widget titleStyle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 24,
    ),
  );
}

Widget descriptionStyle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 25,
      fontFamily: 'DIN 30640 Std',
    ),
  );
}

/*******************************************************
 * ****************FEED***********************
 ********************************************************/

/****************DRAWER******************* */
Widget drawerStyle(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 25,
      fontFamily: 'DIN 30640 Std',
      fontWeight: FontWeight.w500,
    ),
  );
}
/**************************Sobre nos **********************/

Widget aboutUsStyle(String title) {
  return Text(
    title,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

/************************Comissao organizadora *****************************/
Widget coTitleStyle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      color: Colors.white,
    ),
  );
}

/******************Incricoes************************* */

Widget drawerRegisterTitle(BuildContext context, String title, String title2) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: 29, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: title2,
            style: TextStyle(
              fontSize: 32,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
  );
}

Widget drawerRegisterLocation(String location, String locationExplained) {
  return RichText(
    textAlign: TextAlign.left ,
    text: TextSpan(
        text: location,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(
            text: locationExplained,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ]),
  );
}

Widget titleTextStyle(String text) {
  return AutoSizeText(
    text,
    maxLines: 1,
    style: TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w500,
    ),
  );
}


Widget discountTextStyle(String text) {
  return AutoSizeText(
    text,
    maxLines: 3,
    minFontSize: 8,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w300,
    ),
  );
}

/***************************Padrinhos***************************** */

Widget godfathersNameStyle(String name) {
  return AutoSizeText(
    name,
    maxLines: 1,
    style: TextStyle(
      fontSize: 33,
      fontWeight: FontWeight.w800
    ),
  );
}

Widget godfathersTextStyle(String text) {
  return AutoSizeText(
    text,
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300
    ),
  );
}

/*****************Sponsors************************** */

/****************************FAQS************************ */

Widget faqsQuestionStyle(String title) {
  return AutoSizeText(
    title,
    maxLines: 2,
    minFontSize: 10,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 25,
      color: Colors.black,
    ),
  );
}

Widget faqsAwnsersStyle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

/***************************contactos**************************/
Widget contactStyle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  );
}

/***********************End of DRAWER ************/

/*************************************************
 * **************End of FEED************************
 ********************************************************/

/**********************************************
 * ****************IPSS
 ****************************************/

Widget ipssText(String text) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

/************************************************
 * *****************Countdown********************
 **********************************/

Widget countdownTextStyle(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
  );
}

/**********************************************
 * **************fim do countdown******************
 ******************************************/

/************************************************
 * ****************PROFILE ********************
 ********************************************/

Widget nameStyle(String name) {
  return AutoSizeText(
    name,
    maxLines: 1,
    minFontSize: 10,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  );
}

/*************************************************
 * **************End of PROFILE************************
 ********************************************************/

Widget wrongInputFieldsTextStyle(String text) {
  return AutoSizeText(
    text,
    maxLines: 1,
    minFontSize: 8,
    style: TextStyle(
      color: Colors.red,
    ),
  );
}

Widget forgotPasswordTextStyle(String text) {
  return AutoSizeText(
    text,
    maxLines: 1,
    minFontSize: 10,
    style: TextStyle(
      fontSize: 14,
    ),
  );
}

