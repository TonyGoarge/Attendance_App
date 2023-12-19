import 'package:new_attendance/cubit/state.dart';
import 'package:new_attendance/screen/todayscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import '../Styles/Colors.dart';
import '../components/component.dart';
import '../components/constant.dart';
import '../cubit/cubit.dart';
import '../models/login_model.dart';






class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit
            .get(context)
            .model;
        namecontroller.text = userModel!.name.toString();
        phonecontroller.text = userModel.phone.toString();
        emailcontroller.text = userModel.email.toString();
        screenWidth = MediaQuery
            .of(context)
            .size
            .width;
        screenHeight = MediaQuery
            .of(context)
            .size
            .height;


        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                if (state is GetUserLoadinglState)
                  LinearProgressIndicator(),
                if (state is GetUserLoadinglState)
                  SizedBox(
                    height: 10.0,
                  ),
                defaultformfield(
                  controller: namecontroller,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  type: TextInputType.name,
                  label: 'Name',
                  prefix: Icons.person,

                ),
                SizedBox(
                  height: screenHeight / 20,
                ),

                defaultformfield(
                  controller: phonecontroller,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  type: TextInputType.phone,
                  label: 'Phone',
                  prefix: Icons.call,

                ),
                SizedBox(
                  height: screenHeight / 20,

                ),
                defaultformfield(
                  controller: emailcontroller,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Email must not be empty';
                    }
                    return null;
                  },
                  type: TextInputType.text,
                  label: 'Email',
                  prefix: Icons.email_outlined,
                ),
                SizedBox(
                  height: screenHeight / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            maxRadius: 30.0,
                            child: IconButton(

                              onPressed: () {
                                Signout(context);
                              },
                              icon: Icon(Icons.logout),
                              iconSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'SGIN OUT',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,

                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 20,),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            maxRadius: 30.0,
                            child: IconButton(

                              onPressed: () {
                                HomeCubit.get(context).updateUser(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    email: emailcontroller.text
                                );
                              },
                              icon: Icon(Icons.update),
                              iconSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'UPDATE',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,

                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}







// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController nameController = TextEditingController();
//
//   final TextEditingController phoneController = TextEditingController();
//
//   final TextEditingController emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                 defaultformfield(
//                   controller: nameController,
//                   validate: (value) {
//                     if (value.isEmpty) {
//                       return 'Name must not be empty';
//                     }
//                     return null;
//                   },
//                   type: TextInputType.name,
//                   label: 'Name',
//                   prefix: Icons.person,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 20,
//                 ),
//                 defaultformfield(
//                   controller: phoneController,
//                   validate: (value) {
//                     if (value.isEmpty) {
//                       return 'Phone must not be empty';
//                     }
//                     return null;
//                   },
//                   type: TextInputType.phone,
//                   label: 'Phone',
//                   prefix: Icons.call,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 20,
//                 ),
//                 defaultformfield(
//                   controller: emailController,
//                   validate: (value) {
//                     if (value.isEmpty) {
//                       return 'Email must not be empty';
//                     }
//                     return null;
//                   },
//                   type: TextInputType.text,
//                   label: 'Email',
//                   prefix: Icons.email_outlined,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: primary,
//                             maxRadius: 30.0,
//                             child: IconButton(
//                               onPressed: () {
//                                 Signout(context);
//                               },
//                               icon: Icon(Icons.logout),
//                               iconSize: 30.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             'SIGN OUT',
//                             style: Theme.of(context).textTheme.bodyText1,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 20,
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: primary,
//                             maxRadius: 30.0,
//                             child: IconButton(
//                                onPressed: () {
//                                 HomeCubit.get(context).updateUser(
//                                   name: nameController.text,
//                                   phone: phoneController.text,
//                                   email: emailController.text,
//                                 );
//                               },
//                               icon: Icon(Icons.update),
//                               iconSize: 30.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             'UPDATE',
//                             style: Theme.of(context).textTheme.bodyText1,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//
//
//   }
// }
//