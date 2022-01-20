import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/components.dart';

class Favorite_Screen extends StatelessWidget {
  const Favorite_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! loadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => BuildListProduct(ShopCubit.get(context).favoritesModels!.data!.data[index].product , context),
            separatorBuilder: (context, index) => MyDivider(),
            itemCount: ShopCubit.get(context).favoritesModels!.data!.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}