// import 'package:attendance/components/component.dart';
//
// import 'package:flutter/material.dart';
//
// import 'login_screen2.dart';
//
// class Choose extends StatefulWidget {
//   const Choose({Key? key}) : super(key: key);
//
//   @override
//   State<Choose> createState() => _ChooseState();
// }
//
// class _ChooseState extends State<Choose> {
//   @override
//     bool ismale=true;
//    double height=120.5;
//    int weight=30;
//    int age=16;
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Welcome',
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//
//         children:
//         [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//
//                 children:
//                 [
//                   GestureDetector(
//
//                     onTap:(){
//                       setState(()
//                       {
//                         ismale=true;
//                       });
//                     } ,
//                     child: Container(
//                       height: 150.0,
//                       width: 150.0,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//
//                         mainAxisAlignment: MainAxisAlignment.center,
//
//                         children:
//                         [
//                           // Image(
//                           //   image:NetworkImage(
//                           //     'https://o.remove.bg/downloads/04fb34ab-9876-4086-a744-219deb13aa4a/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv-removebg-preview.png',
//                           //   ),
//                           //   height: 90.0,
//                           //   width: 90.0,
//                           //
//                           // ),
//                           SizedBox(
//                             height:15.0,
//                           ),
//                           Text(
//                             'ADMIN',
//                             style: TextStyle(
//                               fontSize: 25.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0,),
//                         color: ismale ? Colors.red : Colors.grey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       setState(()
//                       {
//                         ismale=false;
//                         NavigatorandFinish(context, LoginScreen());
//                       });
//                     },
//                     child: Container(
//                       height: 150.0,
//                       width: 150.0,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children:
//                         [
//                           // Image(
//                           //   image:NetworkImage(
//                           //       'https://o.remove.bg/downloads/4edda0c5-b891-4488-b045-7bcb9c4c6959/1000_F_275240716_SXAMlDcJkhf7ii2FGhGF9RuT3D8GHyeZ-removebg-preview.png'
//                           //   ),
//                           //   height: 90.0,
//                           //   width: 90.0,
//                           // ),
//                           SizedBox(
//                             height:15.0,
//                           ),
//                           Text(
//                             'EMPLOYEES',
//                             style: TextStyle(
//                               fontSize: 25.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0,),
//                         color: !ismale ? Colors.red : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//
//
//
//         ],
//       ),
//     );
//
//    }
//
// }
