import 'dart:async';
import 'dart:core';

import 'package:bed_availablity/pages/hospitalList.dart';
import 'package:bed_availablity/shared/constants.dart';
import 'package:bed_availablity/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool loading = false;
  String maxTimeStamp = DateTime.now().toIso8601String();
  late StreamSubscription<Event> _counterSubscription;
  final databaseRef = FirebaseDatabase.instance.reference();
  int countcurrentBedsG = 0;
  int countcurrentBedsGOxy = 0;
  int countcurrentBedsGwOxy = 0;
  int countcurrentBedsI = 0;
  int countcurrentBedsGVenti = 0;
  int countcurrentBedsGwVenti = 0;
  int counttotalGBeds = 0;
  int counttotalBedsGOxy = 0;
  int counttotalBedsGwOxy = 0;
  int counttotalIBeds = 0;
  int counttotalBedsGVenti = 0;
  int counttotalBedsGwVenti = 0;

  @override
  void initState() {
    _counterSubscription = databaseRef.onValue.listen((Event event) {
      setState(() {
        getData();
        // DateTime maxDate = listTimeStamp[0];
        // listTimeStamp.forEach((date) {
        //   if (date.isAfter(maxDate)) {
        //     maxDate = date;
        //   }
        // });
        // // print(maxDate);

        // maxTimeStamp = maxDate.toString();
      });
    }, onError: (Object o) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _counterSubscription.cancel();
  }

  late List<DateTime> listTimeStamp;
  void getData() {
    // databaseRef.once().then((DataSnapshot snapshot) {
    //   var hospitalList = snapshot.value['HospitalInfo'].values;
    //   print(hospitalList["HospitalAddress"]);
    //   print('Data : ${snapshot.value['HospitalInfo']}');
    // });

    databaseRef.child("HospitalInfo").once().then((DataSnapshot data) {
      databaseRef.keepSynced(true);
      // print(data.value);
      Map<dynamic, dynamic> test = data.value as Map<dynamic, dynamic>;
      test.forEach((key, value) {
        //print(value["HospitalAddress"]);

        countcurrentBedsG += int.parse(value["CurrentBedsG"]);
        countcurrentBedsGOxy += int.parse(value["CurrentBedsGOxy"]);
        countcurrentBedsGVenti += int.parse(value["CurrentBedsGVenti"]);
        countcurrentBedsGwOxy += int.parse(value["CurrentBedsGWOxy"]);
        countcurrentBedsGwVenti += int.parse(value["CurrentBedsGWVenti"]);
        countcurrentBedsI += int.parse(value["CurrentBedsI"]);

        counttotalGBeds += int.parse(value["TotalBedsG"]);
        counttotalBedsGOxy += int.parse(value["TotalBedsGOxy"]);
        counttotalBedsGwOxy += int.parse(value["TotalBedsGWOxy"]);
        counttotalIBeds += int.parse(value["TotalBedsI"]);
        counttotalBedsGVenti += int.parse(value["TotalBedsGVenti"]);
        counttotalBedsGwVenti += int.parse(value["TotalBedsGWVenti"]);
        // if (value["TimeStamp"] != null) {
        //   listTimeStamp.add(
        //       new DateFormat('dd-MM-yyyy – kk:mm').parse(value["TimeStamp"]));
        // }
        //var test = HospitalInfo.fromMap(value);
      });
    });

    // print(listTimeStamp[0].substring(0, listTimeStamp[0].length - 3));
    // print(new DateFormat('yyyy/MM/dd HH:mm:ss').parse('2020/04/03 17:03:02'));
    // print(new DateFormat('dd-MM-yyyy HH:mm:ss').parse(listTimeStamp[0]));
    //var dateList2 = listTimeStamp.map(DateTime.parse);

    //maxDate.toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Bed Availablity"),
              elevation: .1,
              backgroundColor: Colors.grey,
              actions: [
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.refresh_rounded),
                        onPressed: () {
                          getData();
                        }),
                  ],
                ),
              ],
            ),
            body: Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      // child: Row(
                      //   children: [
                      //     Text('Last Updated on : ',
                      //         style: TextStyle(
                      //             fontSize: 10.0,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w900)),
                      //     Text(maxTimeStamp,
                      //         style: TextStyle(
                      //             fontSize: 10.0,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w900)),
                      //   ],
                      // ),
                    ),
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.all(3.0),
                        children: <Widget>[
                          makeItemDashboard("Total General Beds Available",
                              (counttotalGBeds - countcurrentBedsG).toString()),
                          makeItemDashboard("Total ICU Beds Available",
                              (counttotalIBeds - countcurrentBedsI).toString()),
                          makeItemDashboard(
                              "Total General Beds with Oxygen Available",
                              (counttotalBedsGOxy - countcurrentBedsGOxy)
                                  .toString()),
                          makeItemDashboard(
                              "Total ICU Beds with Ventilators Available",
                              (counttotalBedsGVenti - countcurrentBedsGVenti)
                                  .toString()),
                          makeItemDashboard(
                              "Total General Beds without Oxygen Available",
                              (counttotalBedsGwOxy - countcurrentBedsGwOxy)
                                  .toString()),
                          makeItemDashboard(
                              "Total ICU Beds without Ventilators Available",
                              (counttotalBedsGwVenti - countcurrentBedsGwVenti)
                                  .toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Card makeItemDashboard(String title, String data) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: RandomColorModel().getColor(),
          ),
          child: new InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HospitalList()));
              countcurrentBedsG = 0;
              countcurrentBedsGOxy = 0;
              countcurrentBedsGwOxy = 0;
              countcurrentBedsI = 0;
              countcurrentBedsGVenti = 0;
              countcurrentBedsGwVenti = 0;
              counttotalGBeds = 0;
              counttotalBedsGOxy = 0;
              counttotalBedsGwOxy = 0;
              counttotalIBeds = 0;
              counttotalBedsGVenti = 0;
              counttotalBedsGwVenti = 0;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data,
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: new Center(
                          child: new Text(title,
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ),

                // new Center(
                //   child: new Text(title,
                //       style:
                //           new TextStyle(fontSize: 18.0, color: Colors.black)),
                // )
              ],
            ),
          ),
        ));
  }
}
