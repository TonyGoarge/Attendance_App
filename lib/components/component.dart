import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_attendance/Styles/Colors.dart';

Widget defaultformfield({
  required TextEditingController? controller,
  required TextInputType  type,
  String? hintText,
  required String label,
  final FormFieldValidator? validate,
  TextStyle? hintStyle =const TextStyle(
    color: primary,
  ),


  Function(String)? onChanged ,
  Function(String)? onSubmit ,
  IconData? suffix,
  VoidCallback? suffixPressed,
  required IconData? prefix,
  VoidCallback? onPressedfun,
  bool obscureText = false,

})=> Material(
  elevation: 0.0,
  borderRadius: BorderRadius.circular(30.0),
  child: Container(
    child:TextFormField(
      controller:controller,
      keyboardType:type,
      onChanged: onChanged,
      onFieldSubmitted:onSubmit,
      onTap: suffixPressed,
      validator: validate,
      obscureText:obscureText,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: primary,

      decoration: InputDecoration(
        hintText:label,
        hintStyle:hintStyle,
        // new TextStyle(
        //   color: Colors.blue,
        // ),

        border:OutlineInputBorder(

          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(30.0)
        ),
        // focusedBorder:OutlineInputBorder(

        //   borderSide:
        //   BorderSide(
        //       color: Colors.grey,width: 1),
        // ),

        prefixIcon: Icon(
          prefix,
        ),

        suffixIcon: Icon(
          suffix,
        ),


      ),
    ),
  ),
);


Widget defaultbotton({
  width=double.infinity,
  height=40.0,
  Color background=primary,
  bool toUpperCase=true,
  final double radius=0.0,
  final VoidCallback? function,
  required String text,
})=>
    Container(
      width: width,
      height:height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          toUpperCase?  text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,

      ),

    );




Widget   defaulttextbutton({
  final VoidCallback? onpress,
  bool toUpperCase=true,
  Color background=primary,

  required String text,
})=>TextButton(

  onPressed: onpress,
  child: Text(
    toUpperCase?  text.toUpperCase():text,
    style: TextStyle(
      color: background,
    ),
  ),
);




void ShowToast(
    {
      required String text,
      required ToastStates state ,
    })=>
    Fluttertoast.showToast(

      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates{SUCCESS,ERROR,WARNING}
Color ChooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}



void  NavigatorandFinish(context,widget)=> Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    ),

);

void  NavigatorTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    )
);













