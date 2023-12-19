

import '../Network/local/cache_helper.dart';
import '../login/loginscreen.dart';
import 'component.dart';


void Signout(context)
{
  CachHelper.removeData(key: 'uId').then((value) {
    NavigatorandFinish(context, LoginScreen(),);
  });
}

void printfulltext(String? text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) =>print(match.group(0)));
}

String? token=CachHelper.getData(key: 'token');
String? uId=CachHelper.getData(key: 'uId');
String? uid=uId;

