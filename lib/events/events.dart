import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:timeshare/constants.dart';
import 'package:timeshare/events/eventPage.dart';

class EventsListPage extends StatefulWidget {
  List meetings, meetingsCopy;
  List<String> categories;
  Map user;
  String uid;
  EventsListPage(
      {this.meetings, this.meetingsCopy, this.categories, this.user, this.uid});

  @override
  _EventsListPageState createState() => _EventsListPageState(
      meetings: meetings,
      meetingsCopy: meetings,
      categories: categories,
      user: user,
      uid: uid);
}

class _EventsListPageState extends State<EventsListPage> {
  List meetings, meetingsCopy;
  List<String> categories;
  Map user;
  String uid;
  _EventsListPageState(
      {this.meetings, this.meetingsCopy, this.categories, this.user, this.uid});
  String search;
  List filterCategories = [];
  bool dateFilter = false;
  String fromDate, toDate;
  initState() {
    makeCategoryFilter();
    super.initState();
  }

  List categoriesFilter = [];
  Widget makeEventList(height, width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: meetings.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              print(user['profilePic']);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.1),
                  userDetailsSection(user['firstName'] + ' ' + user['lastName'],
                      uid, user['profilePic']),
                  SizedBox(height: height * 0.03),
                  Row(
                    children: [
                      Text(
                        'Events Near You',
                        style: kHeading3Style.copyWith(
                            fontWeight: FontWeight.w500),
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
                              child: FaIcon(FontAwesomeIcons.search,
                                  size: height * 0.025, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                ],
              );
            } else if (index <= meetings.length) {
              index -= 1;
              Map meeting = meetings[index]['data'];
              String meetingID = meetings[index]['id'];
              if (meeting['hostUID'] == uid) {
                return Center();
              }
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.003),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(width * 0.016),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                width: width * 0.18,
                                height: height * 0.1,
                                imageUrl: meeting['hostProfilePic'],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
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
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            SizedBox(
                                width: width * 0.62,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            'Date - ' +
                                                meeting['date']
                                                    .split('-')
                                                    .reversed
                                                    .join('/') +
                                                ', ' +
                                                meeting['time'],
                                            style: kHeading4Style.copyWith(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500)),
                                        Spacer(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // FaIcon(
                                        //     FontAwesomeIcons.clock,
                                        //     size: height * 0.018,
                                        //     color: Colors.black45,
                                        //   ),
                                        Text(
                                            'Duration - ' + meeting['duration'],
                                            style: kHeading4Style.copyWith(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500)),
                                        //   SizedBox(width: width * 0.005),
                                        //   Text(';',
                                        //       style: kHeading4Style.copyWith(
                                        //           fontWeight: FontWeight.w500,
                                        //           color: Colors.black54))
                                      ],
                                    ),
                                    Text(
                                      meeting['category'],
                                      style: kHeading2Style.copyWith(
                                          fontWeight: FontWeight.w500),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Row(
                                      children: [
                                        Text('HOST - ',
                                            style: kHeading5Style.copyWith(
                                                color: Colors.black54)),
                                        Text(meeting['hostName'],
                                            style: kHeading5Style.copyWith(
                                                color: blue3))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: height * 0.018,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: width * 0.015),
                                        Expanded(
                                          child: Text(
                                              meeting['address'] +
                                                  ', ' +
                                                  meeting['city'],
                                              style: kHeading5Style.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54)),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: blue3,
                        ),
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.05),
                                      color: blue3.withOpacity(0.5)),
                                  child: Row(
                                      children: makeAttendeeCircles(
                                          height, width, meeting['attendees'])),
                                ),
                                Spacer(),
                                TextButton(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical:6, horizontal: 16),
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
                                            builder: (context) => EventPage(
                                                meetings: meetings,
                                                meeting: meeting,
                                                meetingID: meetingID,
                                                user: user,
                                                uid: uid)));
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(Size.zero),
                                    padding: MaterialStateProperty.all(EdgeInsets.zero,),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(blue3),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),),);
            } else {
              return SizedBox(height: height * 0.1);
            }
          }),
    );
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  makeFilter(context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          decoration: linerGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.08),
              Center(
                child: Text(
                  'SEARCH EVENT',
                  style: kHeading3Style.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: inputFieldDecorationWhite.copyWith(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(height),
                              bottomLeft: Radius.circular(height))),
                      height: height * 0.05,
                      width: width * 0.7,
                      child: Row(
                        children: [
                          SizedBox(
                            width: height * 0.015,
                          ),
                          FaIcon(FontAwesomeIcons.search,
                              size: height * 0.02, color: blue3),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search For user'),
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
                    decoration: inputFieldDecorationWhite.copyWith(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(height),
                            bottomRight: Radius.circular(height)),
                        color: Colors.black),
                    child: IconButton(
                      onPressed: () {
                        print(search);
                        if (search != null) {
                          setState(() {
                            filterBySearch(search);
                            search = null;
                          });
                        } else {
                          setState(() {
                            meetings = meetingsCopy;
                          });
                        }
                        Navigator.pop(context);
                      },
                      icon:
                          FaIcon(FontAwesomeIcons.search, color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.05),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  activeColor: Colors.white,
                  checkColor: blue3,
                  dense: true,
                  title: Text('Search By Date :', style: kHeading3Style),

                  value: dateFilter,
                  onChanged: (newValue) {
                    setState(() {
                      dateFilter = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.trailing, //  <-- leading Checkbox
                ),
              ),
              SizedBox(height: height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Text('From Date', style: kInputLabelStyle),
                      ),
                      Container(
                        decoration: inputFieldDecorationWhite,
                        width: width * 0.42,
                        child: SizedBox(
                          height: height * 0.05,
                          child: DateTimePicker(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: width * 0.03),
                                hintText: "dd/mm/yyyy"),
                            initialValue: (fromDate != null) ? fromDate : '',
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            onChanged: (val) {
                              if (val != null) {
                                fromDate = val;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Text('To Date', style: kInputLabelStyle),
                      ),
                      Container(
                        decoration: inputFieldDecorationWhite,
                        width: width * 0.42,
                        child: Padding(
                          padding: EdgeInsets.all(height * 0.0),
                          child: SizedBox(
                            height: height * 0.05,
                            child: DateTimePicker(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: width * 0.03),
                                  hintText: "dd/mm/yyyy"),
                              initialValue: (toDate != null) ? toDate : '',
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              onChanged: (val) {
                                if (val != null) {
                                  toDate = val;
                                }
                              },
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
              Text('  Search By Meeting Category :', style: kHeading3Style),
              Expanded(
                child: ListView.builder(
                    itemCount: categoriesFilter.length,
                    itemBuilder: (context, index) {
                      return StatefulBuilder(
                        builder: (context, setState) => CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: blue3,
                          dense: true,
                          title: Text(categoriesFilter[index]['category'],
                              style: TextStyle(
                                  fontSize: height * 0.025,
                                  fontWeight: FontWeight.w500)),

                          value: categoriesFilter[index]['filterValue'],
                          onChanged: (newValue) {
                            if (newValue) {
                              filterCategories
                                  .add(categoriesFilter[index]['category']);
                            } else {
                              filterCategories
                                  .remove(categoriesFilter[index]['category']);
                            }
                            setState(() {
                              categoriesFilter[index]['filterValue'] = newValue;
                            });
                            print(filterCategories);
                          },
                          controlAffinity: ListTileControlAffinity
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
                      "APPLY",
                      style: kButtonText,
                    ),
                  ),
                ),
                onPressed: () {
                  if (filterCategories.length > 0) {
                    filterByCategory();
                  } else {
                    setState(() {
                      meetings = meetingsCopy;
                    });
                  }
                  List auxillarymeetings = meetings;
                  if (dateFilter) {
                    if (fromDate != null && toDate != null) {
                      filterByDate(auxillarymeetings, fromDate, toDate);
                    } else {
                      snackBar('Enter Dates Correctly');
                    }
                  } else {
                    setState(() {
                      meetings = auxillarymeetings;
                    });
                  }

                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
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
        circles.add(
          Container(
            height: height * 0.04,
            width: height * 0.04,
            child: Card(
              elevation: 0,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                imageUrl: attendees[i]['image'],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(
                        backgroundColor: blue3,
                        valueColor: AlwaysStoppedAnimation<Color>(blue1),
                        value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height),
              ),
            ),
          ),
        );
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

  makeCategoryFilter() {
    for (int i = 1; i < categories.length; i++) {
      categoriesFilter.add({'category': categories[i], 'filterValue': false});
    }
  }

  filterByCategory() {
    meetings = [];
    meetingsCopy.forEach((element) {
      if (filterCategories.contains(element['data']['category'])) {
        meetings.add(element);
      }
    });
    print(meetings);
  }

  filterByDate(m, from, to) {
    DateTime fdate = DateTime.parse(from);
    DateTime tdate = DateTime.parse(to).add(Duration(days: 1));
    print(fdate);
    print(tdate);
    meetings = [];
    m.forEach((element) {
      DateTime eventDate = DateTime.parse(element['data']['date']);

      if (eventDate.isAfter(fdate) && eventDate.isBefore(tdate)) {
        meetings.add(element);
      }
    });
  }

  filterBySearch(search) {
    meetings = [];
    meetingsCopy.forEach((element) {
      search = search.toLowerCase();
      Map data = element['data'];
      print(data['category']);
      if (data['address'].toLowerCase().contains(search) ||
          data['category'].toLowerCase().contains(search) ||
          data['city'].toLowerCase().contains(search) ||
          data['hostName'].toLowerCase().contains(search) ||
          data['locality'].toLowerCase().contains(search) ||
          data['pinCode'].toLowerCase().contains(search) ||
          data['hostUID'].toLowerCase().contains(search) ||
          data['state'].toLowerCase().contains(search)) {
        print('added');
        meetings.add(element);
      }
    });
  }
}
