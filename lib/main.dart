import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/data_layer/cache_helper.dart';
import 'package:news_app/data_layer/dio_helper.dart';
import 'package:news_app/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusinessNews()
        ..getSportsNews()
        ..getScienceNews(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              primarySwatch: Colors.deepPurple,
              iconTheme: IconThemeData(
                color: Colors.purple,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.yellowAccent,
                iconTheme: IconThemeData(
                  color: Colors.purple,
                ),
                elevation: 0,
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.purple,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.yellowAccent,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.yellowAccent,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                unselectedItemColor: Colors.purple.shade200,
                elevation: 5,
              ),
            ),
            darkTheme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              scaffoldBackgroundColor: Colors.blueGrey.shade900,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blueGrey.shade900,
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blueGrey.shade900,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.blueGrey.shade900,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                unselectedItemColor: Colors.grey.shade600,
                elevation: 5,
              ),
            ),
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
