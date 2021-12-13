import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchedNews(value);
                  },
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.purple,
                      ),
                      labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                ),
              ),
              Expanded(
                child: Article(
                  list: list,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
