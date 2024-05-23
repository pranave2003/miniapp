import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Date and Time',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime? datepick = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (datepick != null) {
                  setState(() {
                    _selectedDate = datepick;
                  });
                }
              },
              child: Text('Date'),
            ),
            SizedBox(height: 20),
            if (_selectedDate != null)
              // Text("$_selectedDate"),
              Text(
                'Selected Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
