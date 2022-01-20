import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/login/login_screen.dart';
import 'package:shop_app/layout/settings/setting_screen.dart';
import 'package:shop_app/layout/srearch/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class Home_Layout extends StatelessWidget {
   Home_Layout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text('Shop App',style: TextStyle(color: Colors.black45),),
              titleSpacing: 20.0,
              actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: (){
                  navigateTo(context, Search_Screen());
                }, icon: Icon(Icons.search_sharp),color: Colors.black54,),
              )
           ],
          ),
          body: cubit.bottomsScreen[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.black12,
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            backgroundColor: Colors.white,
            items: const <Widget>[
              Icon( Icons.home, size: 30,color: Colors.black45,),
              Icon(Icons.apps,color: Colors.black45,),
              Icon(Icons.favorite_border,size:30,color: Colors.black45,),
              Icon( Icons.settings , size:30,color: Colors.black45,),
            ],
          ),
        );
      },
    );
  }
}