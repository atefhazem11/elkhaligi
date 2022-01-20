import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/layout/register/cubit/state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/local/dio_halper.dart';
import 'package:shop_app/shared/network/remote/end_point.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)  => BlocProvider.of(context);
  late LoginModel loginModel ;

  void  UserRegister({
   required String name,
   required String email,
   required String password,
   required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
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

 emit(ShopRegisterChangePasswordVisibilityState());
}

}