import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:timeshare/constants.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';
import 'package:timeshare/events/eventPage.dart';
import '../customDatatypes/eventDatatype.dart';

class EventsListPage extends StatelessWidget {
  String search;
  List events = [
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ])
  ];
  List categories = [
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false},
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false},
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false},
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false},
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false},
    {'category': 'Inhouse Ludo', 'filterValue': false},
    {'category': 'Inhouse Carrom', 'filterValue': false},
    {'category': 'Movie Time', 'filterValue': false}
  ];
  Widget makeEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: events.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                userDetails,
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    Text(
                      'Events Near You',
                      style: kHeading3Style,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        makeFilter(context);
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(height * 0.00),
                          child: Center(
                            child: Icon(Icons.filter_list,
                                size: height * 0.05, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
              ],
            );
          } else if (index <= events.length) {
            index -= 1;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.003),
              child: Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.005),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  events[index].fromTime +
                                      ' - ' +
                                      events[index].toTime,
                                  style: kHeading5Style),
                              Spacer(),
                              Text(events[index].date, style: kHeading5Style)
                            ],
                          ),
                          Text(events[index].category,
                              style: kHeading2Style.copyWith(
                                  fontFamily: 'PoorStory')),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text('HOST - ', style: kHeading4Style),
                              Text(events[index].hostName,
                                  style: kHeading4Style.copyWith(color: blue3))
                            ],
                          ),
                          Text(
                              events[index].address + ', ' + events[index].city,
                              style: kHeading5Style.copyWith(
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.051,
                                width: width * 0.5,
                                child: Stack(
                                    children: makeAttendeeCircles(height, width,
                                        events[index].attendees)),
                              ),
                              Spacer(),
                              TextButton(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  child: new Text(
                                    "Join",
                                    style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventPage()));
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(blue3),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      // side: BorderSide(
                                      //     color: Colors.black, width: 1.5),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            );
          } else {
            return SizedBox(height: height * 0.1);
          }
        });
  }
  
  makeFilter(context){
    return showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              decoration: linerGradient,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.08),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: inputFieldDecorationWhite
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  height),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  height))),
                                          height: height * 0.05,
                                          width: width * 0.7,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.search,
                                                  size: height * 0.02,
                                                  color: blue3),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Search For user'),
                                                  onChanged: (input) {
                                                    search = input;
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                      SizedBox(width: width * 0.01),
                                      Container(
                                        width: width * 0.15,
                                        height: height * 0.05,
                                        decoration:
                                            inputFieldDecorationWhite.copyWith(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(height),
                                                    bottomRight:
                                                        Radius.circular(
                                                            height)),
                                                color: Colors.black),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(FontAwesomeIcons.search,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.05),
                                  Text('Filter By Date :',
                                      style: kHeading3Style),
                                  SizedBox(height: height * 0.015),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.03),
                                            child: Text('From Date',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                            decoration:
                                                inputFieldDecorationWhite,
                                            width: width * 0.42,
                                            child: SizedBox(
                                              height: height * 0.05,
                                              child: DateTimePicker(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left:
                                                                width * 0.03),
                                                    hintText: "dd/mm/yyyy"),
                                                initialValue: '',
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                                onChanged: (val) =>
                                                    print(val),
                                                validator: (val) {
                                                  print(val);
                                                  return null;
                                                },
                                                onSaved: (val) => print(val),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.03),
                                            child: Text('To Date',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                            decoration:
                                                inputFieldDecorationWhite,
                                            width: width * 0.42,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(height * 0.0),
                                              child: SizedBox(
                                                height: height * 0.05,
                                                child: DateTimePicker(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left:
                                                                  width * 0.03),
                                                      hintText: "dd/mm/yyyy"),
                                                  initialValue: '',
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                  onChanged: (val) =>
                                                      print(val),
                                                  validator: (val) {
                                                    print(val);
                                                    return null;
                                                  },
                                                  onSaved: (val) => print(val),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Divider(),
                                  SizedBox(height: height * 0.02),
                                  Text('Filter By Meeting Category :',
                                      style: kHeading3Style),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: categories.length,
                                        itemBuilder: (context, index) {
                                          return StatefulBuilder(
                                            builder: (context, setState) =>
                                                CheckboxListTile(
                                              activeColor: Colors.white,
                                              checkColor: blue3,
                                              dense: true,
                                              title: Text(
                                                  categories[index]['category'],
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontWeight:
                                                          FontWeight.w500)),

                                              value: categories[index]
                                                  ['filterValue'],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  categories[index]
                                                          ['filterValue'] =
                                                      newValue;
                                                });
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing, //  <-- leading Checkbox
                                            ),
                                          );
                                        }),
                                  ),
                                  TextButton(
                                    child: Container(
                                      height: height * 0.035,
                                      width: width * 0.9,
                                      child: Center(
                                        child: Text(
                                          "UPDATE",
                                          style: kButtonText,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01)
                                ],
                              )),
                        );
  }

  List<Widget> makeAttendeeCircles(height, width, attendees) {
    List<Widget> circles = [];
    for (int i = 0; i < attendees.length; i++) {
      if (i < 3) {
        circles.add(Positioned(
          left: height * i / 100,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jfif'),
            radius: height * 0.025,
          ),
        ));
      } else {
        circles.add(Positioned(
          left: height * 0.08,
          top: height * 0.0125,
          child: Text('+' + (attendees.length - 3).toString(),
              style: kHeading4Style),
        ));
        break;
      }
    }
    return circles;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return makeEventList(height, width);
  }
}
