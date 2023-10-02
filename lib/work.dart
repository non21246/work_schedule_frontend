import 'package:flutter/material.dart';
import 'package:work_schedule/dashboard.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  var Null = null;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != Null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != Null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    ))!;
    if (picked != Null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    ))!;
    if (picked != Null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดตารางงานของคุณ'),
        backgroundColor: Color(0xFFFFCA79),
        actions: [
          IconButton(
            icon: Icon(Icons.save), // ไอคอนบันทึก
            onPressed: () {
              // กระบวนการเมื่อปุ่มบันทึกถูกกด
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFECCF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ชื่องานของคุณ',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'คำอธิบายงานของคุณ',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {},
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    await _selectStartDate(context);
                    await _selectStartTime(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text(
                        'วันเริ่มต้น: ${startDate?.toString().split(' ')[0] ?? 'เลือก'} ${startTime?.format(context) ?? '00:00'}',
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    await _selectEndDate(context);
                    await _selectEndTime(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text(
                        'วันครบกำหนด: ${endDate?.toString().split(' ')[0] ?? 'เลือก'} ${endTime?.format(context) ?? '00:00'}',
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(), // เปลี่ยนเป็นหน้าหลักที่คุณต้องการไป
                    ),
                  );
                },
                child: Text(
                  'บันทึก',
                  style: TextStyle(
                    color: Colors.black, // สีตัวหนังสือเป็นสีดำ
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFCA79), // สีพื้นหลังเป็นสี 255, 202, 121
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
