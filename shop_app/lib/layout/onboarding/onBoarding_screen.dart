// ignore: file_names
// ignore: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_app/layout/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(
        image: 'assets/images/boarding.jpg',
        body: ''
            'Find your desried products from thousands of products !',
        title: 'Shop Anything',
    ),
    BoardingModel(
      image: 'assets/images/boarding3.jpg',
      body: 'Easily order any products you want to buy !',
      title: 'Order Easily',
    ),
    BoardingModel(
      image: 'assets/images/boarding..jpg',
      body: 'Order will be Delivered to your doorstep in quickest time possible !',
      title: 'Fast Delivery',
    ),
  ];

  bool isLast = false;
 var boardController = PageController();

 void submitBoard ()
 {
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
     if(value)
     {
       navigateAndFinished(context, Login_Screen());
     }
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
                submitBoard();
              },
              child: Text('SKIP',)
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if (index == boarding.length  - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                   effect: ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     activeDotColor: defaultColor,
                     dotHeight: 12,
                     dotWidth: 12,
                     expansionFactor: 4,
                     spacing: 6,
                   ),
                    controller: boardController,
                    count: boarding.length,
                  ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submitBoard();
                    }else
                      {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 25.0, color: Colors.black,fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 25.0, color: Colors.black54,),
          ),
        ],
      );
}