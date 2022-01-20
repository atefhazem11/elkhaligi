import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newss_app/shared/components/components.dart';
import 'package:newss_app/shared/cubit/cubit.dart';
import 'package:newss_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: defaultTextField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (String value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    onValidate: (String? value) {
                      if (value!.isEmpty) {
                        return ' Search must not be empty ';
                      }
                    },
                    prefix: Icons.search,
                    label: 'search',
                    ),
              ),
         Expanded(child: buildArcticle(context , list: list , isSearch: true, )),
        ],
          ),
        );
      },
    );
  }
}
