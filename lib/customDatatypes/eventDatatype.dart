import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';

class Event{
  String fromTime,toTime,date,category,hostName,address,city;
  List<Attendee> attendees;
  List<Attendee> requests;
  Event({this.fromTime,this.toTime,this.date,this.category,this.hostName,this.address,this.city,this.attendees,this.requests});
}