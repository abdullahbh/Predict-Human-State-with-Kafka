// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

double a_x = 0;
double a_y = 0;
double a_z = 0;

double g_x = 0;
double g_y = 0;
double g_z = 0;

List accData = [];
StreamSubscription? _accelSubscription;
StreamSubscription? _gyroSubscription;
String? ip;

void main() => runApp(FlutterSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'BDA-APP',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: Reading(),
      );
    }));

class Reading extends StatefulWidget {
  const Reading({Key? key}) : super(key: key);

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BDA App"),
          backgroundColor: Colors.grey.shade700,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 15.h,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.4.w),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.4.w),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Enter IP",
                          labelText: "IP"),
                      onChanged: (value) {
                        ip = value;
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Table(
                    textDirection: TextDirection.ltr,
                    border: TableBorder.symmetric(
                      inside: BorderSide(width: 1),
                    ),
                    // border: TableBorder.all(width: 0.5.w, color: Colors.grey),
                    columnWidths: const {
                      0: FixedColumnWidth(150),
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          "Sensor",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "X",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Y",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Z",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Accelerometer",
                          style: TextStyle(fontSize: 21),
                        ),
                        Text(
                          "$a_x",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$a_y",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$a_z",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Gyroscope",
                          style: TextStyle(fontSize: 21),
                        ),
                        Text(
                          "$g_x",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$g_y",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$g_z",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: (() {
                      stopReading();
                    }),
                    label: const Text(
                      "Pause",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FloatingActionButton.extended(
                      label: Text(
                        "Start",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: (() {
                        startReading();
                      }))
                ],
              ),
            ],
          ),
        ));
  }

  void startReading() async {
    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.ACCELEROMETER,
      interval: Sensors.SENSOR_DELAY_NORMAL,
    );

    _accelSubscription = stream.listen((sensorEvent) {
      setState(() {
        a_x = sensorEvent.data[0];
        a_y = sensorEvent.data[1];
        a_z = sensorEvent.data[2];
      });
    });

    final streamm = await SensorManager().sensorUpdates(
      sensorId: Sensors.GYROSCOPE,
      interval: Sensors.SENSOR_DELAY_NORMAL,
    );

    _gyroSubscription = streamm.listen((sensorEvent) {
      setState(() {
        g_x = sensorEvent.data[0];
        g_y = sensorEvent.data[1];
        g_z = sensorEvent.data[2];
      });
    });

    final url = Uri.parse("http://127.0.0.1:5000/detect");
    final response = await http.post(url,
        body: json.encode({
          'A_X': a_x,
          'A_Y': a_y,
          'A_Z': a_z,
          'G_X': g_x,
          'G_Y': g_y,
          'G_Z': g_z
        }));
  }

  void stopReading() {
    _accelSubscription!.pause();
    _gyroSubscription!.pause();
  }
}
