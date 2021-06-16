import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/drawer/drawer.dart';

class ContactUs extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer.getDrawer(context, height, width),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                height: height,
                width: width,
                decoration: linerGradient,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: height * 0.1),
                    Center(child: logo),
                    SizedBox(height: height * 0.05),
                    Text('CONTACT US', style: kHeading2Style),
                    SizedBox(height: height * 0.03),
                    Text('E-mail : ',
                        style: kHeading4Style.copyWith(
                            fontWeight: FontWeight.w400)),
                    Text('share2care@gmail.com', style: kHeading4Style),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text('Contact : ',
                        style: kHeading4Style.copyWith(
                            fontWeight: FontWeight.w400)),
                    Text('9999999999', style: kHeading5Style),
                    SizedBox(height: height * 0.03),
                    Text(
                      'Name',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your name'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'E-mail',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your email'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'Meaasge',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 7,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Message'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                    Center(
                      child: Container(
                        decoration: inputFieldDecorationWhite,
                          child: IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.paperPlane,
                                  color: blue3))),
                    )
                  ],
                )),
            Positioned(
                top: height * 0.06,
                left: width * 0.05,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                      height: height * 0.05,
                      width: height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height),
                          color: Colors.white),
                      child: Center(
                          child: FaIcon(FontAwesomeIcons.bars, color: blue3))),
                )),
          ],
        ));
  }
}
