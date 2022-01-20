import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/categories/categories_Screen.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/favorite/favorite_screen.dart';
import 'package:shop_app/layout/products/products_screen.dart';
import 'package:shop_app/layout/settings/setting_screen.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/local/dio_halper.dart';
import 'package:shop_app/shared/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomsScreen = [
    Products_Screen(),
    Categories_Screen(),
    Favorite_Screen(),
    Setting_Screen(),
  ];
  void ChangeBottom(int index)
  {
    currentIndex = index;
    emit(BottomNavStates());
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


  HomeModel? homeModel;
  Map <int , bool> favorites = {};
  void getHomeData ()
  {
    emit(LoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
     homeModel =  HomeModel.fromJson(value.data);
     PrintFullText(homeModel!.data!.toString());
     PrintFullText(homeModel!.status.toString());

     homeModel!.data!.products!.forEach((element)
     {
       favorites.addAll({
       element.id! : element.inFavorites!,
       });
     });
      emit(SuccessHomeDataState());
    })
        .catchError((error){
          print(error.toString());
          emit(ErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories ()
  {
    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel =  CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorCategoriesState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite(int productId) {

    favorites[productId] = !favorites[productId]!;

    emit(ChangeFavoritesState());
    DioHelper.postData(
      url: FAVOURITES,
      data: {'product_id': productId,},
      token: token,
    )
    .then((value)
    {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if(!changeFavoriteModel!.status!){
        favorites[productId] =! favorites[productId]!;

      }else{
        getFavotites();
      }
      //print(value.data);


      emit(SuccessChangeFavoritesState(changeFavoriteModel!));
    })
        .catchError((error){

      favorites[productId] =! favorites[productId]!;
      emit(ErrorChangeFavoritesState());

     print(error.toString());
    });
  }

  FavoritesModels? favoritesModels;
  void getFavotites ()
  {

    emit(loadingGetFavoritesState());

    DioHelper.getData(url: FAVOURITES, token: token,)
        .then((value) {
      favoritesModels =  FavoritesModels.fromJson(value.data);
     //print(value.data.toString());
      emit(SuccessGetFavoritesState());
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorGetFavoritesState());
    });
  }


  LoginModel? userProfile;
  void getProfile ()
  {

    emit(loadingGetFavoritesState());

    DioHelper.getData(url: PROFILE, token: token,)
        .then((value) {
      userProfile =  LoginModel.fromJson(value.data);
     print(userProfile!.data!.name.toString());
      emit(SuccessUserProfileState(userProfile!));
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorUserProfileState());
    });
  }


  void UpdateProfile (
  {
  required String name,
  required String email,
  required String phone,
})
  {

    emit(loadingUserUpdateState());

    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data : {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    )
        .then((value) {
      userProfile =  LoginModel.fromJson(value.data);
     print(userProfile!.data!.name.toString());
      emit(SuccessUserUpdateState(userProfile!));
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorUserUpdateState());
    });
  }
}