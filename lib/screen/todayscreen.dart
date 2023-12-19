import 'dart:async';

import 'package:new_attendance/Styles/Colors.dart';
import 'package:new_attendance/cubit/cubit.dart';
import 'package:new_attendance/models/login_model.dart';
import 'package:new_attendance/screen/readqr.dart';
import 'package:new_attendance/services/location_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../components/component.dart';



class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> with SingleTickerProviderStateMixin{
  double screenHeight = 0;
  double screenWidth = 0;
  String checkIn ="--/--";
  String checkOut ="--/--";
  String location= " ";
  // late AnimationController _controller;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _getRecord(context);
    _startLocationService();
    createAnimationController();
    resetSlideAction();
    disposeAnimationController();
    // getRecord(context);
  }

  // @override
  // void dispose() {
  //   _controller.dispose(); // Dispose the controller properly
  //   super.dispose();
  // }


  void createAnimationController() {
    controller = AnimationController(vsync: this,
      // Animation controller configuration
    );
  }

  void disposeAnimationController() {
    controller.dispose();
  }

  void resetSlideAction() {
    if (controller != null && controller.status != AnimationStatus.dismissed) {
      controller.reset();
    }
  }




  // void getRecord(context) async {
  //   try {
  //     // User? user = FirebaseAuth.instance.currentUser;
  //      var user = HomeCubit.get(context).model;
  //
  //     if (user != null) {
  //       String userEmail = user.uId ?? '';
  //
  //       QuerySnapshot userSnapshot = await FirebaseFirestore.instance
  //           .collection("Users")
  //           .where('email', isEqualTo: userEmail)
  //           .get();
  //
  //       if (userSnapshot.docs.isNotEmpty) {
  //         String? userId = user.uId;
  //
  //         DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
  //             .collection("Users")
  //             .doc(userId)
  //             .collection("Record")
  //             .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
  //             .get();
  //
  //         if (recordSnapshot.exists) {
  //           setState(() {
  //             print('Check is done');
  //             checkIn = recordSnapshot['checkIn'];
  //             checkOut = recordSnapshot['checkOut'];
  //
  //           });
  //
  //         } else {
  //           print('Record does not exist');
  //         }
  //       } else {
  //         print('User not found');
  //       }
  //     }
  //   } catch (e) {
  //     print('Error retrieving record: $e');
  //   }
  //   print(checkIn);
  //   print(checkOut);
  // }

  void _getRecord(context) async {
    try {
           var user = HomeCubit.get(context).model;

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Users")
          .where('id', isEqualTo: user?.uId)
          .get();

      ////////////////////////////////////////////
      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user?.uId)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
      setState(() {

        checkIn = snap2["checkIn"];
        checkOut = snap2["checkOut"];
      });
    } catch (e)
    {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
    print('checkin'+checkIn);
    print('checkout'+checkOut);
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


  @override
  Widget build(BuildContext context) {
    var userModel=HomeCubit.get(context).model;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "CairoRegular",
                  fontSize: screenWidth / 20),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Users  " +'${userModel?.name}',
              style: TextStyle(
                fontFamily: "Cairo-Bold",
                fontSize: screenWidth / 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "Today's Status",
              style: TextStyle(
                  fontFamily: "CairoBold", fontSize: screenWidth / 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 25),
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        checkIn,
                        style: TextStyle(
                          fontFamily: "CairoBold",
                          fontSize: screenWidth / 19,
                        ),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check Out",
                        style: TextStyle(
                          fontFamily: "CairoRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        checkOut,
                        style: TextStyle(
                          fontFamily: "CairoBold",
                          fontSize: screenWidth / 19,
                        ),
                      )
                    ],
                  ))
                ]),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: DateTime.now().day.toString(),
                    style: TextStyle(
                      color: primary,
                      fontFamily: "CairoBold",
                      fontSize: screenWidth / 18,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth / 20),
                      )
                    ]),
              )),
          StreamBuilder(
              stream: Stream.periodic( Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat(' hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: "CairoRegular",
                      fontSize: screenWidth / 20,
                      color: Colors.black54,
                    ),
                  ),
                );
              }),
          checkOut == "--/--"
          ?Container(
            margin: const EdgeInsets.only(top: 24,bottom: 12),
            child: Builder(builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();

              return SlideAction(
                text: checkIn=="--/--"?"Slide to check In":"Slide to check Out"  ,
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth / 20,
                  fontFamily: "CairoRegular",
                ),
                outerColor: Colors.white,
                innerColor: primary,
                key: key,
                onSubmit: () async{
                  resetSlideAction();

                  if(Users.lat != 0){
                _getLocation();

                print(DateFormat('hh:mm').format(DateTime.now()));
                QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection("Users")
                    .where('id', isEqualTo: '${userModel?.uId}')
                    .get();
                print(userModel?.uId);

                DocumentSnapshot snap2 = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(userModel?.uId)
                    .collection("Record")
                    .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                    .get();

                try {
                  String checkIn = snap2['checkIn'];
                  setState(() {
                    checkOut=DateFormat('hh:mm').format(DateTime.now());
                  });
                  print(Users.lat);
                  print(Users.long);
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userModel?.uId)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                      .update({
                    'date':Timestamp.now(),
                    'checkIn': checkIn,
                    'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                    'checkOutLocation':location,

                  });
                } catch (e) {
                  setState(() {
                    checkIn=DateFormat('hh:mm').format(DateTime.now());
                  });
                  print(Users.lat);
                  print(Users.long);
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userModel?.uId)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                      .set({
                    'date':Timestamp.now(),
                    'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                    'checkOut': "--/--",
                    'checkInLocation':location,


                  });
                }
                final state = key.currentState;
                if (state != null) {
                  state.reset();
                }
              }else{
                Timer(const Duration(seconds: 3),() async {
                  _getLocation();

                  print(DateFormat('hh:mm').format(DateTime.now()));
                  QuerySnapshot snap = await FirebaseFirestore.instance
                      .collection("Users")
                      .where('id', isEqualTo: '${userModel?.uId}')
                      .get();
                  print(userModel?.uId);

                  DocumentSnapshot snap2 = await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userModel?.uId)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                      .get();

                  try {
                    String checkIn = snap2['checkIn'];
                    setState(() {
                      checkOut=DateFormat('hh:mm').format(DateTime.now());
                    });
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(userModel?.uId)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .update({
                      'date':Timestamp.now(),
                      'checkIn': checkIn,
                      'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                      'checkOutLocation':location,

                    });
                  } catch (e)
                  {
                    setState(() {
                      checkIn=DateFormat('hh:mm').format(DateTime.now());
                    });
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(userModel?.uId)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .set({
                      'date':Timestamp.now(),
                      'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                      'checkOut': "--/--",
                      'checkInLocation':location,
                    });
                  }
                  key.currentState!.reset();
                });
              }
                }

              );
            }),
          )
              : Container(
            margin: EdgeInsets.only(top: 32,bottom: 32),
               child: Text(
              'You Have Complete This Day !',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "CairoBold",
                fontSize: screenWidth / 18,),
          ),
          ),
          location != " " ?
          Text(
              "Location: "+location,
          ):const SizedBox(),
          SizedBox(height: 15,),
          // Column(
          //   children: [
          //     Stack(
          //       alignment: Alignment.center,
          //       children:
          //        [
          //          IconButton(
          //            onPressed: () {
          //            NavigatorTo(context, ScanScreen());
          //            },
          //            icon: Icon(
          //
          //               FontAwesomeIcons.expand,
          //             size: 70,
          //             color: primary,
          //         ),
          //          ),
          //          IconButton(
          //            onPressed: () {
          //              NavigatorTo(context, ScanScreen());
          //            },
          //          icon : Icon(
          //             FontAwesomeIcons.camera,
          //           size: 30,
          //           color: primary,
          //         ),
          //          ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15),
          // Container(
          //     child: Row(
          //       children: [
          //         ElevatedButton(
          //           onPressed: () {
          //             // NavigatorTo(context, CreateScreen());
          //           },
          //           child: Text('Create QR code'),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
                      // NavigatorTo(context, ScanScreen());
          //           },
          //           child: Text('Scan QR code'),
          //         ),
          //       ],
          //     )),

        ],
      ),
    ));
  }
}
