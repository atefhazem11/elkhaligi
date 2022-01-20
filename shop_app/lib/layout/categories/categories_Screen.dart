import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => BuildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget BuildCatItem(DataModel model) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          width: 150,
          height: 150.0,
          color: Colors.white,
          child: Row(
            children: [
              Image(image: NetworkImage(
                  model.image!),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text('${model.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      );
}