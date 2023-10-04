import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:work_schedule/work.dart';
import 'package:work_schedule/http.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  String selectedValue = 'กำลังทำ';
  String name = 'งาน Flutter';
  String description = 'ไม่มีไรทำ';
  String startDate = '2023-10-05';
  String endDate = '2023-10-06';
  String startTime = '7-30 AM';
  String endTime = '8-30 PM';
  List<Map<String, dynamic>> workList = [
    {
      'name': '',
      'description': '',
      'startDate': '',
      'endDate': '',
      'startTime': '',
      'endTime': '',
      'workStatus': '',
    }
  ];
  Future<List<Map<String, dynamic>>> getAllWork() async {
    try {
      var response = await http.get(Uri.parse(getAllwork),
          headers: {"Content-Type": "application/json"});
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse is List) {
          workList = List<Map<String, dynamic>>.from(jsonResponse);
        } else if (jsonResponse is Map) {
          workList.add(Map<String, dynamic>.from(jsonResponse));
          name = workList[0]['name'];
          description = workList[1]['description'];
          startDate = workList[2]['startDate'];
          endDate = workList[3]['endDate'];
          startTime = workList[4]['startTime'];
          endTime = workList[5]['endTime'];
          selectedValue = workList[6]['status'];
        } else {
          throw ("Invalid response format");
        }
      } else {
        throw ("No data received");
      }
    } catch (error) {
      throw error;
    }

    return workList;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getAllWork();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   getAllWork();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCA79),
        title: Align(
          alignment: Alignment.center,
          child: Text("My Dashboard"),
        ),
      ),
      backgroundColor: Color.fromRGBO(243, 223, 192, 1),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              height: 230,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '$name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('วันเริ่มต้น: $startDate $startTime')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('วันครบกำหนด: $endDate $endTime')
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              DropdownButton<String>(
                                value: selectedValue,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'กำลังทำ',
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('กำลังทำ'),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'แก้ไข',
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('แก้ไข'),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'เสร็จสิ้น',
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('เสร็จสิ้น'),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10), // เพิ่มระยะห่าง 10 px
                                  ElevatedButton(
                                    onPressed: () {
                                      // กระทำเมื่อปุ่ม "แก้ไข" ถูกกด
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.black,
                                      elevation: 5,
                                    ),
                                    child: Text('แก้ไข'),
                                  ),
                                  SizedBox(width: 10), // เพิ่มระยะห่าง 10 px
                                  ElevatedButton(
                                    onPressed: () {
                                      // กระทำเมื่อปุ่ม "ลบ" ถูกกด
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkPage()),
          );
        },
        backgroundColor: Colors.green, // กำหนดสีพื้นหลังของปุ่มเป็นสีเขียว
        foregroundColor: Colors.white, // กำหนดสีของไอคอนเป็นสีขาว
        shape: CircleBorder(), // กำหนดรูปร่างของปุ่มเป็นวงกลม
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
