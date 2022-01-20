import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/cubit.dart';
import 'package:shop_app/layout/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/local/dio_halper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home/home_layout.dart';
import 'layout/onboarding/onBoarding_screen.dart';

void main() async
{
  BlocOverrides.runZoned(
        () {
      ShopLoginCubit();
      ShopCubit();
    },
    blocObserver: MyBlocObserver(),);
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
   Widget widget;

  bool? onBoarding  = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') ;
  print(token);
late Widget strartWidget = OnBoardingScreen();
if (onBoarding != null) {
  if (token != null) {widget = Home_Layout();}
  else {widget = Login_Screen();}}
 else {widget = OnBoardingScreen();}

  runApp(MyApp(
    startWidget : widget,
  ));
}

class MyApp extends StatelessWidget {
   final Widget startWidget;
   MyApp({ required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavotites()..getProfile(),//..changeAppMode(fromShared: isDark!),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: startWidget,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}