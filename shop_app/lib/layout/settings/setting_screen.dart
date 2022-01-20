import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class Setting_Screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userProfile;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userProfile != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children:
                  [
                    if(state is loadingUserProfileState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 40.0,
                    ),
                    defaultTextField(
                      controller: nameController,
                      type: TextInputType.name,
                      onValidate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      onValidate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      onValidate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    defaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).UpdateProfile(
                             name: nameController.text,
                             phone: phoneController.text,
                             email: emailController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          if (value) {
                            navigateAndFinished(context, Login_Screen());
                          }
                        });
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}