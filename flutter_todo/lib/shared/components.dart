import 'package:flutter/material.dart';

// هنا بيتكتب اي حاجه هتتكرر كتبر

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required Function function,
  required String text,
  double raduis = 0.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function;
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchanged,
  required Function validate,
  required String label,
  required IconData prefix,
  bool? isPassword,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onsubmit!(s);
      },
      onChanged: (s) {
        onchanged!(s);
      },
      validator: (s) {
        validate!(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );
