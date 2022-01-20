import 'package:social_app/models/notification_model.dart';
import 'package:social_app/modules/screens/login_screen/login_screen.dart';

import 'components.dart';
import '../network/lacal/cache_helper.dart';


void signOutFun(context){
  CachHelper.clearDataFromSharedPreference(key: 'uID')
      .then((value) {
    if(value)
      print('');
    navigateAndFinish(context, LoginScreen());
  });
}

String? uID = ' ';

List<NotificationModel> notificationList =[];

String daysBetween(DateTime postDate){
  if  ((DateTime.now().difference(postDate).inHours / 24).round() == 0)
  {
    if(DateTime.now().difference(postDate).inHours == 0 )
      if(DateTime.now().difference(postDate).inMinutes == 0)
        return 'now';
      else
        return '${DateTime.now().difference(postDate).inMinutes.toString()} minutes';
    else
      return '${DateTime.now().difference(postDate).inHours.toString()} hours';
  }
  else
  {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} days');
  }
}