

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/local/dio_halper.dart';
import 'package:shop_app/shared/network/remote/end_point.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)  => BlocProvider.of(context);
  late LoginModel loginModel ;

  void  UserLogin({
   required String email,
   required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api//',
          receiveDataWhenStatusError: true,
          // headers: {
          //   'Content-Type': 'application/json'
          //}
        ),
      );
      print(error.toString());
    });
}


  bool isPassword = true;
  IconData suffix =Icons.visibility_outlined;
void ChangePasswordVisibility ()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

 emit(ShopChangePasswordVisibilityState());
}

}