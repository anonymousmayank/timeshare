import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:timeshare/constants.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  List<String> category = ['Inhouse Ludo', 'Inhouse Carrom', 'Movie Time'];

  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: ListView(
          padding: EdgeInsets.all(0),
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        userDetails,
        SizedBox(
          height: height * 0.03,
        ),
        Text(
          'Create New Meeting',
          style: kHeading3Style,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Text(
          'Meeting Category',
          style:
              kHeading4Style,
        ),
        SizedBox(height: height * 0.008),
        Card(
          child: Container(
            decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.005),
                      color:Colors.white,),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Text('Select Category of Meeting'),
                ),
                isExpanded: true,
                items: category.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          'Date & Time of Meeting',
          style:kHeading4Style,
        ),
        SizedBox(height: height * 0.008),
        Card(
          child: Container(
            decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.005),
                      color:Colors.white
                    ),
            child: Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Time",
                autovalidate: true,
                style: TextStyle(fontSize: height * 0.02),
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          'Duration of Meeting',
          style:kHeading4Style,
        ),
        SizedBox(height: height * 0.008),
        Card(
          child: Container(
            decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.005),
                      color:Colors.white
                    ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.01),
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter Duration (HH:MM)'),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: height * 0.02,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       'Address',
        //       style: kHeading4Style,
        //     ),
        //     Expanded(
        //       child: CheckboxListTile(
        //         activeColor: Colors.white,
        //         checkColor: Color(0xFF70A6EF),
        //         dense: true,
        //         title: Text("Select Default Address",style:TextStyle(color:Colors.black)),
        //         subtitle: Text('Create Meeting at your address',style:TextStyle(color:Colors.black)),
                
        //         value: checkedValue,
        //         onChanged: (newValue) {
        //           setState(() {
        //             checkedValue = newValue;
        //           });
        //         },
        //         controlAffinity:
        //             ListTileControlAffinity.trailing, //  <-- leading Checkbox
        //       ),
        //     ),
        //   ],
        // ),
        // Card(
        //   child: Container(
        //     decoration: new BoxDecoration(
        //               borderRadius: BorderRadius.circular(height * 0.005),
        //               gradient: new LinearGradient(
        //                   colors: [
        //                     Colors.white.withOpacity(0.9),
        //                 Colors.white.withOpacity(0.9)
        //                   ],
        //                   begin: FractionalOffset(0.0, 0.0),
        //                   end: FractionalOffset(0.1, 1.0),
        //                   stops: [0.1, 1.0],
        //                   tileMode: TileMode.clamp),
        //             ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: height * 0.01),
        //       child: TextField(
        //         keyboardType: TextInputType.datetime,
        //         decoration: InputDecoration(
        //             border: InputBorder.none,
        //             labelText: 'Address Line 1',
        //             hintText: 'Apartment Number/House Number'),
        //       ),
        //     ),
        //   ),
        // ),
        // Card(
        //   child: Container(
        //     decoration: new BoxDecoration(
        //               borderRadius: BorderRadius.circular(height * 0.005),
        //               gradient: new LinearGradient(
        //                   colors: [
        //                     Colors.white.withOpacity(0.9),
        //                 Colors.white.withOpacity(0.9)
        //                   ],
        //                   begin: FractionalOffset(0.0, 0.0),
        //                   end: FractionalOffset(0.1, 1.0),
        //                   stops: [0.1, 1.0],
        //                   tileMode: TileMode.clamp),
        //             ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: height * 0.01),
        //       child: TextField(
        //         keyboardType: TextInputType.datetime,
        //         decoration: InputDecoration(
        //             labelText: 'Address Line 2',
        //             border: InputBorder.none,
        //             hintText: 'Apartment Name/Street Name'),
        //       ),
        //     ),
        //   ),
        // ),
        // Card(
        //   child: Container(
        //     decoration: new BoxDecoration(
        //               borderRadius: BorderRadius.circular(height * 0.005),
        //               gradient: new LinearGradient(
        //                   colors: [
        //                     Colors.white.withOpacity(0.9),
        //                 Colors.white.withOpacity(0.9)
        //                   ],
        //                   begin: FractionalOffset(0.0, 0.0),
        //                   end: FractionalOffset(0.1, 1.0),
        //                   stops: [0.1, 1.0],
        //                   tileMode: TileMode.clamp),
        //             ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: height * 0.01),
        //       child: TextField(
        //         keyboardType: TextInputType.datetime,
        //         decoration: InputDecoration(
        //             labelText: 'Address Line 3',
        //             border: InputBorder.none,
        //             hintText: 'City/District'),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          'Number of Guests',
          style:kHeading4Style,
        ),
        SizedBox(height: height * 0.008),
        Card(
          child: Container(
            decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.005),
                      color:Colors.white
                    ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.01),
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Maximum Guests Invited'),
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.05),
            TextButton(
              child: Container(
                height: height * 0.035,
                width: width * 0.9,
                child: Center(
                  child: Text(
                    "CREATE",
                    style: kButtonText,
                  ),
                ),
              ),
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
      ],
    ));
  }
}
