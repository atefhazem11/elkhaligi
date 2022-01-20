import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home/home_layout.dart';
import 'package:shop_app/layout/login/cubit/cubit.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/layout/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token
              ).then((value) {

                token = state.loginModel.data!.token;
                navigateAndFinished(context, Home_Layout());
              });
            }else
            {
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red.shade200,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }

        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        SizedBox(
                          height: 35.0,
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 30.0,

                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black54
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        defaultTextField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onValidate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'email address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value){
                            if (_formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          } ,
                          suffixPress: (){
                             ShopLoginCubit.get(context).ChangePasswordVisibility();

                          },
                          onValidate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          label: 'password',
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) =>
                             defaultButton(
                               radius: 15.0,
                                 function: ()
                                 {
                                 if (_formKey.currentState!.validate())
                                 {
                                   ShopLoginCubit.get(context).UserLogin(
                                     email: emailController.text,
                                     password: passwordController.text,
                                   );
                                 }

                                 },
                                 text: 'LOGIN',
                             ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black54
                              ),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context,  Register_Screen());
                                },
                                child: Text('REGISTER',)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
