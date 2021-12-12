import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double height = ui.window.physicalSize.height / ui.window.devicePixelRatio;
double width = ui.window.physicalSize.width / ui.window.devicePixelRatio;

Color blue1 = Color(0xFFCFE4FD);
Color blue2 = Color(0xFF84A6D1);
Color blue3 = Color(0xFF70A6EF);
Color red = Colors.red;
Color green = Color(0xFF00e600);
Color yellow = Color(0xFFffd500);

TextStyle kHeading1Style =
    TextStyle(fontSize: 28, fontWeight: FontWeight.w500);
TextStyle kHeading2Style =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
TextStyle kHeading3Style =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
TextStyle kHeading4Style =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
TextStyle kHeading5Style = TextStyle(
    fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
TextStyle kHeading6Style = TextStyle(
    fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
TextStyle kInputLabelStyle =
    TextStyle(fontSize: 16, color: Colors.black);
TextStyle kButtonText = TextStyle(
    fontSize: 18, letterSpacing: 1.5, fontWeight: FontWeight.bold);

BoxDecoration linerGradient = BoxDecoration(
  borderRadius: BorderRadius.circular(height * 0.005),
  gradient: new LinearGradient(
      colors: [blue1, blue2, blue3],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(0.0, 1.0),
      stops: [0.1, 0.5, 1.0],
      tileMode: TileMode.clamp),
);

BoxDecoration inputFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(height),
    color: Color(0xFF70A6EF).withOpacity(0.8));
BoxDecoration inputFieldDecorationWhite = BoxDecoration(
    borderRadius: BorderRadius.circular(height), color: Colors.white);

BoxDecoration roundedBox = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(height * 0.06),
    ),
    color: Colors.white);

Widget logo = Image.asset(
  'assets/logo.png',
  width: width * 0.8,
  height: height * 0.15,
  color: Colors.black,
);

Widget userDetailsSection(username, String uid, profilePicURL) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username.substring(4),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.038,
                    fontWeight: FontWeight.w600,),
                    softWrap: false,
                    overflow: TextOverflow.fade,),
            Text('Membership Id : ' + uid.substring(uid.length - 6),
                style: kHeading4Style)
          ],
        ),
      ),
      (profilePicURL!='')?Container(
        height: width * 0.25,
        width: width * 0.25,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CachedNetworkImage(
                                      imageUrl: profilePicURL,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          LinearProgressIndicator(
                                              backgroundColor: blue3,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      blue1),
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height),
          ),
          elevation: 5,
        ),
      ):Center,
    ],
  );
}

Widget getNavigationButton(context) {
  return Positioned(
    left: width * 0.04,
    top: height * 0.015,
    child: IconButton(
      icon: FaIcon(
        FontAwesomeIcons.chevronCircleLeft,
        color: Colors.black,
        size: height * 0.06,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

