import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newss_app/moduls/business.dart';
import 'package:newss_app/moduls/science.dart';
import 'package:newss_app/moduls/sport.dart';
import 'package:newss_app/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:newss_app/shared/network/local/cache_helper.dart';
import 'package:newss_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());


  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> BottomItems = [
     BottomNavigationBarItem(
        icon: Icon(Icons.business,),
        label: 'Business',
    ),
     BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_outlined,),
        label: 'Sports',
    ),
     BottomNavigationBarItem(
        icon: Icon(Icons.science,),
        label: 'Science',
    ),
  ];

  List <Widget> Screens =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];


  void changeBottomNavBar (int index) {
    currentIndex = index;
    if(index == 1)
      getSport();
    if( index == 2)
      getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];
  void getBusiness ()
  {
    emit(NewGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'66b02acd61a147dcbaa34a9429a10c41',
      },
      //   country=eg&category=science&apiKey=65f7f556ec76449fa7dc7c0069f040ca
    )
        .then((value) {
      business = value.data['articles'];
      print(business[2]['title']);
      emit(NewGetBusinessSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    }
    );
  }


  List<dynamic> sport = [];
  void getSport ()
  {
    emit(NewGetSportLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'66b02acd61a147dcbaa34a9429a10c41',
      },
      //   country=eg&category=science&apiKey=65f7f556ec76449fa7dc7c0069f040ca
    )
        .then((value) {
      sport = value.data['articles'];
      print(sport[2]['title']);
      emit(NewGetSportSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(NewGetSportErrorState(error.toString()));
    }
    );
  }


  List<dynamic> science = [];
  void getScience ()
  {
    emit(NewGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'66b02acd61a147dcbaa34a9429a10c41',
      },
      //   country=eg&category=science&apiKey=65f7f556ec76449fa7dc7c0069f040ca
    )
        .then((value) {
      science = value.data['articles'];
      print(science[2]['title']);
      emit(NewGetScienceSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(NewGetScienceErrorState(error.toString()));
    }
    );
  }


  List<dynamic> search = [];
  void getSearch ( String value)
  {
    emit(NewGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':value,
        'apiKey':'66b02acd61a147dcbaa34a9429a10c41',
      },
      //   country=eg&category=science&apiKey=65f7f556ec76449fa7dc7c0069f040ca
        )
        .then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    }
    );
  }


  bool isDark = false;
  void changeAppMode ({bool? fromShared}){
    if(fromShared != null)
      isDark = fromShared;
    else
      {
        isDark = !isDark;
        CacheHelper.putBool(key: 'isDark' , value: isDark)
            .then((value){
              emit(AppChangeModeState()
              );
        });
      }
  }
}
