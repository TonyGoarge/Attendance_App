import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_attendance/cubit/cubit.dart';
import 'package:new_attendance/cubit/state.dart';
import 'package:new_attendance/screen/calendascreen.dart';
import 'package:new_attendance/screen/profilescreen.dart';
import 'package:new_attendance/screen/todayscreen.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Styles/Colors.dart';



class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List bottomScreens = HomeCubit().bottomScreens;

  @override
  void initState() {
    super.initState();
    // getId();
  }



  // void getId() async {
  //   var user = HomeCubit.get(context).model;
  //
  //   QuerySnapshot snap = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .where('id', isEqualTo: user?.uId)
  //       .get();
  //   setState(() {
  //     user?.uId=snap.docs[0].id;
  //   });
  // }

  // int currentindex = 0;
  int currentindex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.ChangeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: primary,
                ),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,
                  color: primary,
                ),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: primary,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}



// class _HomeState extends State<Home> {
//   // List  users = [];
//   // CollectionReference usersref = FirebaseFirestore.instance.collection("Users");
//
//   @override
//   void initState() {
//     resetAppState();
//     super.initState();
//   }
//   // getUserData()async{
//   //  var responsebody = await usersref.get();
//   //  responsebody.docs.forEach((element) {
//   //    setState(() {
//   //      users.add(element.data);
//   //    });
//   //  });
//   //   print(users);
//   // }
//
//   void resetAppState() {
//     setState(() {
//       // Reset the state variables as needed
//       currentindex = 1;
//       // Add any other state variables that need resetting
//     });
//   }
//
//
//   double screenHeight = 0;
//   double screenWidth = 0;
//   Color primary = const Color(0xff1670fb);
//   int currentindex = 1;
//   List<IconData> navigationIcons = [
//   FontAwesomeIcons.calendar,
//   FontAwesomeIcons.check,
//   FontAwesomeIcons.user,
// ];
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return  BlocConsumer<HomeCubit,HomeStates>(
//     listener: (context,state){},
//     builder: (context,state){
//
//       return Scaffold(
//         body: IndexedStack(
//           index: currentindex,
//           children:  [
//               CalendarScreen(),
//              TodayScreen(),
//             ProfileScreen(),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           height: 70,
//           margin: const EdgeInsets.only(
//             left: 12,
//             right: 12,
//             bottom: 24,
//           ),
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(40)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
//               ]),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(40)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
//                   Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentindex = i;
//                           });
//                         },
//                         child: Container(
//                           height: screenHeight,
//                           width: screenWidth,
//                           color: Colors.white,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   navigationIcons[i],
//                                   color: i == currentindex ? primary : Colors.black54,
//                                   size: i == currentindex ?30 :26,
//                                 ),
//                                 i == currentindex ? Container(
//                                   margin: EdgeInsets.only(top: 6),
//                                   height: 3,
//                                   width: 22,
//                                   decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(40)),
//                                     color: primary,
//                                   ),
//
//                                 ):
//                                 const SizedBox(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ))
//                 }
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//
//     );
//   }
// }


