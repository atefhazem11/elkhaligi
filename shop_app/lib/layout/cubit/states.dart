
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class InitialStates extends ShopStates{}

class BottomNavStates extends ShopStates{}

class AppChangeModeState extends ShopStates{}

class LoadingHomeDataState extends ShopStates{}

class SuccessHomeDataState extends ShopStates{}

class ErrorHomeDataState extends ShopStates{}

class SuccessCategoriesState extends ShopStates{}

class ErrorCategoriesState extends ShopStates{}

class ChangeFavoritesState extends ShopStates{}

class SuccessChangeFavoritesState extends ShopStates{

  final ChangeFavoriteModel model;

  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends ShopStates{}

class loadingGetFavoritesState extends ShopStates{}

class SuccessGetFavoritesState extends ShopStates{}

class ErrorGetFavoritesState extends ShopStates{}

class loadingUserProfileState extends ShopStates{}

class SuccessUserProfileState extends ShopStates{
  final LoginModel loginModel;

  SuccessUserProfileState(this.loginModel);
}

class ErrorUserProfileState extends ShopStates{}

class loadingUserUpdateState extends ShopStates{}

class SuccessUserUpdateState extends ShopStates{
  final LoginModel loginModel;

  SuccessUserUpdateState(this.loginModel);
}

class ErrorUserUpdateState extends ShopStates{}