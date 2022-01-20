import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Products_Screen extends StatelessWidget {
  const Products_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is SuccessChangeFavoritesState){
          if(!state.model.status!)
          {}
          Fluttertoast.showToast(
              msg: state.model.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder:  (context) => ProductsBuilder(ShopCubit.get(context).homeModel!,  ShopCubit.get(context).categoriesModel! , context),
            fallback: (context) =>  Center(child: CircularProgressIndicator(color: Colors.brown.shade200,),),
        );
      },
    );
  }
  Widget ProductsBuilder(HomeModel model , CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics:  BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners!.map((e) =>
                  Image(image:
                  NetworkImage('${e.image}'),
                  ),).toList(),
              options: CarouselOptions(
               // height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  Categories',
                  style: TextStyle(fontSize: 25.0,color: Colors.black),),
                SizedBox(
                  height: 10.0,
                ),
                 Container(
                   height: 100,
                   child: ListView.separated(
                     physics: BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                       itemBuilder: (context, index) => BuildCategoriesItem(categoriesModel.data!.data[index]),
                       separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
                       itemCount: categoriesModel.data!.data.length,
                   ),
                 ),
                SizedBox(
                  height: 10.0,
                ),
                Text('  New Products',
                  style: TextStyle(fontSize: 25.0,color: Colors.black),),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.blueGrey.shade50,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1/1.6,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(model.data!.products!.length,
                      (index) => BuildGridProducts(model.data!.products![index] , context),
              ),
            ),
          ),
        ],
        ),
  );

  
  Widget BuildCategoriesItem (DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(
          model.image!),
        height: 150,
        width: 150,),
      Container(
        width: 150,
        color: Colors.black.withOpacity(0.3),
        child: Text('${model.name}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
        ),
      ),
    ],
  );

  Widget BuildGridProducts (ProductModel model , context) =>
    Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image!),
                      width: double.infinity,
                      height: 200,
                    ),
                    if(model.discount != 0)
                    Text('DISCOUNT',
                     style: TextStyle(
                       fontSize: 12,
                       backgroundColor: Colors.red,
                       color: Colors.white
                     ),
                    ),
                  ],
                ),
                Text(model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('${model.price!}',
                        style: TextStyle(
                          color: Colors.blue,
                         fontSize: 14.0,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if(model.discount != 0)
                      Text('${model.oldPrice!}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ?  Colors.red : Colors.grey[300],
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: ()
                          {
                            ShopCubit.get(context).changeFavorite(model.id!);
                          },
                          icon: Icon(
                            Icons.favorite_border,
                          size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
}
