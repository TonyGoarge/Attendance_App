
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:new_attendance/Styles/Colors.dart';
import 'package:new_attendance/cubit/cubit.dart';

import '../models/login_model.dart';
import '../services/location_services.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}
String? location= " ";
class _CalendarScreenState extends State<CalendarScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getid();
    _getLocation();
    _startLocationService();
  }




  void _startLocationService() async {

    LocationService().initialize();

    LocationService().getLatitude().then((value) {
      setState(() {
        Users.lat = value!;
      });
      LocationService().getLongitude().then((value)   {
        setState(() {
          Users.long = value!;
        });
      });
    });
  }
  void _getLocation()async{

    List<Placemark> placemark=await placemarkFromCoordinates(Users.lat, Users.long);
    setState(() {
      location="'${placemark[0].street} ,"
          " ${placemark[0].administrativeArea} ,"
          " ${placemark[0].postalCode} ,"
          " ${placemark[0].country}'";

    });
  }


  void getid() async {
    var user = HomeCubit.get(context).model;
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Users")
        .where('id', isEqualTo: user?.uId)
        .get();
    setState(() {
      user!.uId = snap.docs[0].id;
    });
  }

  Widget build(BuildContext context) {
    var userModel = HomeCubit.get(context).model;

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 32, left: 20),
                child: Text(
                  "My Attendance",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth / 18),
                ),
              ),
              Stack(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 32, left: 20),
                  child: Text(
                    _month,
                    style:
                    TextStyle(color: Colors.black, fontSize: screenWidth / 18),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 32, left: 20),
                  child: GestureDetector(
                    onTap: () async {
                      final month = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2099),
                          builder: (context,child){
                            return Theme(
                              data:Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: primary,
                                    secondary: primary,
                                    onSecondary: Colors.white,
                                  ),
                                  textButtonTheme:TextButtonThemeData(style: TextButton.styleFrom(primary: primary))

                              ),
                              child: child!,
                            );
                          }
                      );

                      if (month != null) {
                        setState(() {
                          _month = DateFormat('MMMM').format(month);
                        });
                      }
                    },
                    child: Text(
                      "Pick a Month",
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth / 18),
                    ),
                  ),
                ),
              ]),
              Container(
                height: screenHeight / 1.45,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userModel?.uId)
                      .collection("Record")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return DateFormat('MMMM')
                              .format(snap[index]['date'].toDate()) == _month
                              ? Container(
                            margin: EdgeInsets.only(top:index>0? 12:0, left: 6, right: 6),
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(2, 2)),
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(),
                                      decoration:const  BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(DateFormat('EE dd')
                                              .format(snap[index]['date']
                                              .toDate()))),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Check In",
                                            style: TextStyle(
                                              fontFamily: "CairoRegular",
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            snap[index]['checkIn'],
                                            style: TextStyle(
                                              fontFamily: "CairoBold",
                                              fontSize: screenWidth / 19,
                                            ),
                                          ),

                                        ],
                                      )),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Check Out",
                                            style: TextStyle(
                                              fontFamily: "Cairo-Regular",
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            snap[index]['checkOut'],
                                            style: TextStyle(
                                              fontFamily: "CairoBold",
                                              fontSize: screenWidth / 19,
                                            ),
                                          ),
                                        ],

                                      )),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Location ",
                                            style: TextStyle(
                                              fontFamily: "CairoRegular",
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 2.0,),
                                          Text(
                                            '$location',
                                            style: TextStyle(
                                              fontFamily: "CairoRegular",
                                              fontSize: screenWidth / 22,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],

                                      )),


                                ]
                            ),
                          )
                              : const SizedBox();
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
