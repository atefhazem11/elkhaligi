
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget MyDivider() => Padding(
  padding: const EdgeInsets.all(3.0),
  child: Divider(
    endIndent: 20.0,
    indent: 20.0,
  ),
);

Widget defaultTextField({
  required TextEditingController? controller,
  required TextInputType? type,
  Function()? onTap,
  int lines = 1,
  Function(String)? onChange,
  required String? Function(String?)? onValidate,
   String? Function(String?)? onSubmit,
  bool isPassword = false,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function()? suffixPress,
}) {
  return TextFormField(
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500
    ),
    controller: controller,
    maxLines: lines,
    keyboardType: type,
    obscureText: isPassword,
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: (value) {
      return onValidate!(value);
    },
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixPress, icon: Icon(suffix))
          : null,
      border: OutlineInputBorder(
        gapPadding: 20,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

Widget defaultTextButton({
  required Function function,
  required String text,
}) => TextButton(
  onPressed: function(),
  child: Text(text),
);

Widget defaultButton({
  double width = 400,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: (){function();},
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(

            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinished (context, widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) => widget,
  ), (Route<dynamic> route) => false);
}

void ShowToast (
      { required String text,
        required ToastStates state,

      }
    )
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.white,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates { SUCCESS , ERROR , WARING }

Color ShowToastColor (ToastStates state,)
{
        Color color;
    switch(state){
      case ToastStates.SUCCESS :
        color =  Colors.green;
        break;
        case ToastStates.WARING :
        color =  Colors.redAccent;
        break;
        case ToastStates.ERROR :
        color =  Colors.red;
        break;
    }
    return color;
}

void SignOut (context){
  TextButton(
    onPressed: () {
      CacheHelper.removeData(key: 'token').then((value) {
        if (value) {
          navigateAndFinished(context, Login_Screen());
        }
      });
    },
    child: Text('Signup'),);
}

// ignore: non_constant_identifier_names
void PrintFullText (String text){

  final pattern = RegExp('.{1.800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


Widget BuildListProduct(model , context , {bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorite(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]!
                              ? Colors.red
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );