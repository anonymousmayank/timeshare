import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';

class ScheduledEvents{
  String fromTime,toTime,date,category,hostName,address,city;
  List<Attendee> attendees;
  bool pending,joined;
  ScheduledEvents({this.fromTime,this.toTime,this.date,this.category,this.hostName,this.address,this.city,this.attendees,this.pending,this.joined});
}