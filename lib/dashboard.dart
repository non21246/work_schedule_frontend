import 'package:flutter/material.dart';
import 'package:work_schedule/work.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'), // กำหนดชื่อหน้า Dashboard
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('นี่คือหน้า Dashboard',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WorkPage()), // GGPage เป็นชื่อหน้าตามที่คุณต้องการ
          );
        },
        tooltip: 'ไปหน้า gg', // ข้อความ tooltip
        backgroundColor: Colors.green, // กำหนดสีพื้นหลังของปุ่มเป็นสีเขียว
        child: Icon(
          Icons.add,
          color: Colors.white, // กำหนดสีของไอคอนเป็นสีขาว
        ),
      ),
    );
  }
}
