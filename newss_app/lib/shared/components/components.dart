import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:newss_app/moduls/web_view.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: ()
      {
        navigateTo(context, WebViewScreen(article['url']),);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image:  NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


Widget buildArcticle(context, {var list,isSearch=false}) => Conditional.single(
    context: context,
    conditionBuilder: (context) => list.length > 0,
    widgetBuilder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => MyDivider(),
      itemCount: list.length,
    ),
    fallbackBuilder: (context) =>isSearch? Container():Center(
      child: CircularProgressIndicator(),
    ));



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
  String Function(String?)? onSubmit,
  bool isPassword = false,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function()? suffixPress,
}) {
  return TextFormField(
    style: TextStyle(
      color: Colors.deepOrange,
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
    //autovalidate: true,
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

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
