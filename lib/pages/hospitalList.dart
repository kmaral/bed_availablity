import 'dart:async';

import 'package:bed_availablity/models/hospital.dart';
import 'package:bed_availablity/shared/constants.dart';
import 'package:bed_availablity/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HospitalList extends StatefulWidget {
  @override
  _HospitalListState createState() => _HospitalListState();
}

List<HospitalInfo> hospitalCards = [];

// List<HospitalInfo> hospitalCards = [
//   HospitalInfo(
//       hospitalName: 'District Civil Hospital Vijayapur',
//       hospitalAddress:
//           'District hospital, Athani Rd, Vijayapura, Karnataka 586102',
//       // hospitalMaps: '',
//       // lastUpdateDate: DateTime.now().toString(),
//       helplinePhonenumber1: '',
//       helplinePhonenumber2: ''),
//   HospitalInfo(
//       hospitalName: 'Hussain Hospital',
//       hospitalAddress:
//           'Darga Cross, Solapur Rd, near Manas Residency, Vijayapura, Karnataka 586103',
//       // hospitalMaps: '',
//       // lastUpdateDate: DateTime.now().toString(),
//       helplinePhonenumber1: '08352 222894',
//       helplinePhonenumber2: '8867046220')
// ];

class _HospitalListState extends State<HospitalList> {
  bool loading = false;
  late StreamSubscription<Event> _counterSubscription;
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _counterSubscription = databaseRef.onValue.listen((Event event) {
      this.getData();
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

  void getData() {
    hospitalCards.clear();
    // databaseRef.once().then((DataSnapshot snapshot) {
    //   var hospitalList = snapshot.value['HospitalInfo'].values;
    //   print(hospitalList["HospitalAddress"]);
    //   print('Data : ${snapshot.value['HospitalInfo']}');
    // });

    databaseRef.child("HospitalInfo").once().then((DataSnapshot data) {
      databaseRef.keepSynced(true);
      Map<dynamic, dynamic> test = data.value as Map<dynamic, dynamic>;
      test.forEach((key, value) {
        HospitalInfo hospitalInfo = new HospitalInfo();
        hospitalInfo.hospitalName = key;
        hospitalInfo.hospitalAddress = value["HospitalAddress"];
        hospitalInfo.helplinePhonenumber1 = value["Phonenumber1"];
        hospitalInfo.helplinePhonenumber2 = value["Phonenumber2"];
        hospitalInfo.currentBedsG = value["CurrentBedsG"];
        hospitalInfo.currentBedsGOxy = value["CurrentBedsGOxy"];
        hospitalInfo.currentBedsGwOxy = value["CurrentBedsGWOxy"];
        hospitalInfo.currentBedsI = value["CurrentBedsI"];
        hospitalInfo.currentBedsGVenti = value["CurrentBedsGVenti"];
        hospitalInfo.currentBedsGwVenti = value["CurrentBedsGWVenti"];
        hospitalInfo.totalGBeds = value["TotalBedsG"];
        hospitalInfo.totalBedsGOxy = value["TotalBedsGOxy"];
        hospitalInfo.totalBedsGwOxy = value["TotalBedsGWOxy"];
        hospitalInfo.totalIBeds = value["TotalBedsI"];
        hospitalInfo.totalBedsGVenti = value["TotalBedsGVenti"];
        hospitalInfo.totalBedsGwVenti = value["TotalBedsGWVenti"];
        hospitalInfo.timestmap = value["TimeStamp"];
        hospitalCards.add(hospitalInfo);
      });
    });
  }

  final dbRef = FirebaseDatabase.instance.reference().child("HospitalInfo");
  Widget appBarTitle = new Text("Bed Availablity");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              // title: Text("Bed Availablity"),
              elevation: .1,
              //backgroundColor: Colors.grey,
              centerTitle: true,
              title: appBarTitle,
            ),
            body: FutureBuilder(
                future: dbRef.once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> mapValues = snapshot.data!.value;
                    hospitalCards.clear();
                    mapValues.forEach((key, value) {
                      HospitalInfo hospitalInfo = new HospitalInfo();
                      hospitalInfo.hospitalName = key;
                      hospitalInfo.hospitalAddress = value["HospitalAddress"];
                      hospitalInfo.helplinePhonenumber1 = value["Phonenumber1"];
                      hospitalInfo.helplinePhonenumber2 = value["Phonenumber2"];
                      hospitalInfo.currentBedsG = value["CurrentBedsG"];
                      hospitalInfo.currentBedsGOxy = value["CurrentBedsGOxy"];
                      hospitalInfo.currentBedsGwOxy = value["CurrentBedsGWOxy"];
                      hospitalInfo.currentBedsI = value["CurrentBedsI"];
                      hospitalInfo.currentBedsGVenti =
                          value["CurrentBedsGVenti"];
                      hospitalInfo.currentBedsGwVenti =
                          value["CurrentBedsGWVenti"];
                      hospitalInfo.totalGBeds = value["TotalBedsG"];
                      hospitalInfo.totalBedsGOxy = value["TotalBedsGOxy"];
                      hospitalInfo.totalBedsGwOxy = value["TotalBedsGWOxy"];
                      hospitalInfo.totalIBeds = value["TotalBedsI"];
                      hospitalInfo.totalBedsGVenti = value["TotalBedsGVenti"];
                      hospitalInfo.totalBedsGwVenti = value["TotalBedsGWVenti"];
                      // hospitalInfo.timestmap = value["TimeStamp"];
                      hospitalCards.add(hospitalInfo);
                    });
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: hospitalCards.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.album),
                                      title: Text(
                                          hospitalCards[index].hospitalName),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(hospitalCards[index]
                                              .hospitalAddress),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text('Helpline number: ' +
                                              hospitalCards[index]
                                                  .helplinePhonenumber1),
                                          Text('Helpline number: ' +
                                              hospitalCards[index]
                                                  .helplinePhonenumber2),
                                        ],
                                      ),

                                      // trailing:
                                      //     Text(hospitalCards[index].helplinePhonenumber1),
                                    ),
                                    GridView.extent(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      // childAspectRatio: (2 / 2),
                                      // crossAxisSpacing: 2,
                                      mainAxisSpacing: 3,
                                      padding: EdgeInsets.all(10.0),
                                      maxCrossAxisExtent: 150.0,
                                      children: List.generate(6, (newindex) {
                                        return Container(
                                          padding: EdgeInsets.all(20.0),
                                          child: Center(
                                            child: GridTile(
                                              header: Center(
                                                child: '$newindex' == "0"
                                                    ? Text(
                                                        hospitalCards[index]
                                                                .currentBedsG +
                                                            "/" +
                                                            hospitalCards[index]
                                                                .totalGBeds,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      )
                                                    : '$newindex' == "1"
                                                        ? Text(
                                                            hospitalCards[index]
                                                                    .currentBedsGOxy +
                                                                "/" +
                                                                hospitalCards[
                                                                        index]
                                                                    .totalBedsGOxy,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          )
                                                        : '$newindex' == "2"
                                                            ? Text(
                                                                hospitalCards[
                                                                            index]
                                                                        .currentBedsGwOxy +
                                                                    "/" +
                                                                    hospitalCards[
                                                                            index]
                                                                        .totalBedsGwOxy,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              )
                                                            : '$newindex' == "3"
                                                                ? Text(
                                                                    hospitalCards[index]
                                                                            .currentBedsI +
                                                                        "/" +
                                                                        hospitalCards[index]
                                                                            .totalIBeds,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  )
                                                                : '$newindex' ==
                                                                        "4"
                                                                    ? Text(
                                                                        hospitalCards[index].currentBedsGVenti +
                                                                            "/" +
                                                                            hospitalCards[index].totalBedsGVenti,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w900),
                                                                      )
                                                                    : '$newindex' ==
                                                                            "5"
                                                                        ? Text(
                                                                            hospitalCards[index].currentBedsGwVenti +
                                                                                "/" +
                                                                                hospitalCards[index].totalBedsGwVenti,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w900),
                                                                          )
                                                                        : Text(
                                                                            'Data not available',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w900),
                                                                          ),
                                              ),
                                              footer: Center(
                                                child: '$newindex' == "0"
                                                    ? Text(
                                                        'General Beds',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      )
                                                    : '$newindex' == "1"
                                                        ? Text(
                                                            'General Beds with Oxygen',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          )
                                                        : '$newindex' == "2"
                                                            ? Text(
                                                                'General Beds without Oxygen',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              )
                                                            : '$newindex' == "3"
                                                                ? Text(
                                                                    'ICU Beds',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  )
                                                                : '$newindex' ==
                                                                        "4"
                                                                    ? Text(
                                                                        'ICU Beds With Ventilators',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w900),
                                                                      )
                                                                    : '$newindex' ==
                                                                            "5"
                                                                        ? Text(
                                                                            'ICU Beds Without  Ventilators',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w900),
                                                                          )
                                                                        : Text(
                                                                            'Others',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w900),
                                                                          ),
                                              ),
                                              child: Text(
                                                "",
                                              ),
                                            ),
                                          ),
                                          color: RandomColorModel().getColor(),
                                          margin: EdgeInsets.all(1.0),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return Loading();
                }),
          );
  }
}
