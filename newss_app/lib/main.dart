import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newss_app/shared/bloc_observer.dart';
import 'package:newss_app/shared/cubit/cubit.dart';
import 'package:newss_app/shared/cubit/states.dart';
import 'package:newss_app/shared/network/local/cache_helper.dart';
import 'package:newss_app/shared/network/remote/dio_helper.dart';
import 'layout/news_Layout.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),);
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark  = CacheHelper.getBool(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
   final bool? isDark;
   MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared: isDark)..getBusiness()..getSport()..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: NewsLayout(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              backgroundColor: Colors.white,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                elevation: 0.0,
                titleTextStyle: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                backgroundColor: Colors.white60,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white60,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              backgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                backgroundColor: HexColor('333739'),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode:  NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}





// https://newsapi.Org/v2/top-headlines?country=eg&category=science&apiKey=65f7f556ec76449fa7dc7c0069f040ca