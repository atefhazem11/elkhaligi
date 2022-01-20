
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newss_app/moduls/search.dart';
import 'package:newss_app/shared/components/components.dart';
import 'package:newss_app/shared/cubit/cubit.dart';
import 'package:newss_app/shared/cubit/states.dart';


class NewsLayout extends StatelessWidget
{
  NewsLayout({Key? key}) : super(key: key);

  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer< NewsCubit , NewsStates>(
      listener: (context , state ) {},
      builder: ( context , state )
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
              ),
              IconButton(
                  icon: Icon(Icons.brightness_4),
                  onPressed: ()
                  {
                    NewsCubit.get(context).changeAppMode();
                  },
              ),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.BottomItems,
          ),
        );
      },
    );
  }
}

