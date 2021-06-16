import 'package:flutter/material.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';
import '../customDatatypes/eventDatatype.dart';
import '../customDatatypes/scheduleDatatype.dart';
import 'myEventRequests.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List scheduledEvents = [
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: true,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: false,
        joined: true,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: false,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: true,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ])
  ];
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


  Widget makeJoinedEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: scheduledEvents.length+1,
        itemBuilder: (context, index) {
          if (index < scheduledEvents.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.003),
              child: Card(
                  child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.005),
                    color: Colors.white.withOpacity(0.9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              scheduledEvents[index].fromTime +
                                  ' - ' +
                                  scheduledEvents[index].toTime,
                              style: kHeading5Style),
                          Spacer(),
                          Text(scheduledEvents[index].date,
                              style: kHeading5Style)
                        ],
                      ),
                      Text(scheduledEvents[index].category,
                          style:
                              kHeading2Style.copyWith(fontFamily: 'PoorStory')),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Text('HOST - ', style: kHeading4Style),
                          Text(scheduledEvents[index].hostName,
                              style: kHeading4Style.copyWith(color: blue3))
                        ],
                      ),
                      Text(
                          scheduledEvents[index].address +
                              ', ' +
                              scheduledEvents[index].city,
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
                            width: width * 0.25,
                            child: Stack(
                                children: makeAttendeeCircles(height, width,
                                    scheduledEvents[index].attendees)),
                          ),
                          Spacer(),
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: new Text(
                                scheduledEvents[index].pending
                                    ? "Pending"
                                    : scheduledEvents[index].joined
                                        ? "Joined"
                                        : "Declined",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            onPressed: null,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  scheduledEvents[index].pending
                                      ? Colors.white
                                      : scheduledEvents[index].joined
                                          ? Color(0xFF00e600)
                                          : Colors.red),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.015),
                          (scheduledEvents[index].pending ||
                                  scheduledEvents[index].joined)
                              ? TextButton(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    child: new Text(
                                      "Cancel",
                                      style: TextStyle(fontSize: height * 0.02),
                                    ),
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.white, width: 1.5),
                                      ),
                                    ),
                                  ),
                                )
                              : Center()
                        ],
                      )
                    ],
                  ),
                ),
              )),
            );
          } else {
            return SizedBox(height: height * 0.08);
          }
        });
  }

  Widget makeMyEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: events.length + 1,
        itemBuilder: (context, index) {
          if (index < events.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.003),
              child: Card(
                  child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.005),
                  color:Colors.white.withOpacity(0.9)
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
                          Text(events[index].date,
                              style: kHeading5Style)
                        ],
                      ),
                      Text(events[index].category,
                          style: kHeading2Style.copyWith(fontFamily: 'PoorStory')),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Text('HOST - ',style:kHeading4Style),
                          Text(events[index].hostName,
                              style: kHeading4Style.copyWith(color:blue3))
                        ],
                      ),
                      Text(events[index].address + ', ' + events[index].city,
                          style: kHeading5Style.copyWith(fontWeight: FontWeight.w400)),
                      SizedBox(height: height * 0.005),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.051,
                            width: width * 0.3,
                            child: Stack(
                                children: makeAttendeeCircles(
                                    height, width, events[index].attendees)),
                          ),
                          Spacer(),
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: new Text(
                                "Requests",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventRequestPage(
                                          requests: events[index].requests)));
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  blue3),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
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
          top: height * 0.01,
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
    return Column(
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        userDetails,
        SizedBox(
          height: height * 0.03,
        ),
        TabBar(
          labelStyle: TextStyle(fontSize: height*0.03,fontWeight: FontWeight.w500),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.black,
          indicatorWeight: 2,
            controller: _controller,
            tabs: [Tab(text:'Joined Events'), Tab(text:'My Events')]),
        SizedBox(height:height*0.01),
        SizedBox(
          height:height*0.7,
          child: TabBarView(
            controller: _controller,
            children: [
              makeJoinedEventList(height, width),
              makeMyEventList(height, width)
            ],
          ),
        ),
        // 
      ],
    );
  }
}
