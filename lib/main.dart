import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PracticalTestPage(),
    );
  }
}

class PracticalTestPage extends StatefulWidget {
  @override
  _PracticalTestPageState createState() => _PracticalTestPageState();
}

class _PracticalTestPageState extends State<PracticalTestPage> {
  DateTime calender1SelectedDate = DateTime.now();
  DateTime calender2SelectedDate = DateTime.now().add(Duration(days: 365));
  String dropdown1Value = 'All';
  String dropdown2Value = 'Sunday';
  String dropdown3Value = 'Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practical Test'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: calender1SelectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      calender1SelectedDate = selectedDate;
                    });
                  }
                });
              },
              child: Text('Choose Date for Calendar 1'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: calender2SelectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      calender2SelectedDate = selectedDate;
                    });
                  }
                });
              },
              child: Text('Choose Date for Calendar 2'),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (newValue) {
                setState(() {
                  dropdown1Value = newValue!;
                });
              },
              items: [
                'All',
                '1st',
                '2nd',
                '3rd',
                '4th',
                '5th',
                '6th',
                '7th',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: dropdown2Value,
              onChanged: (newValue) {
                setState(() {
                  dropdown2Value = newValue!;
                });
              },
              items: [
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (newValue) {
                setState(() {
                  dropdown3Value = newValue!;
                });
              },
              items: [
                'Week',
                'Month',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                List<DateTime> resultDates = [];

                DateTime currentDate = calender1SelectedDate;
                DateTime endDate = calender2SelectedDate;

                while (currentDate.isBefore(endDate)) {
                  if (dropdown1Value == 'All' ||
                      (dropdown1Value != 'All' &&
                          DateFormat('EEEE').format(currentDate) ==
                              dropdown2Value &&
                          (dropdown1Value == '1st' ||
                              dropdown1Value == '2nd' ||
                              dropdown1Value == '3rd' ||
                              dropdown1Value == '4th' ||
                              dropdown1Value == '5th' ||
                              dropdown1Value == '6th' ||
                              dropdown1Value == '7th'))) {
                    resultDates.add(currentDate);
                  }

                  if (dropdown3Value == 'Week') {
                    currentDate = currentDate.add(Duration(days: 7));
                  } else if (dropdown3Value == 'Month') {
                    currentDate = currentDate.add(Duration(days: 30));
                  }
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Result'),
                      content: Text(resultDates.join('\n')),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
