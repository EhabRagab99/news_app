import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business/business_screen.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/data_layer/cache_helper.dart';
import 'package:news_app/data_layer/dio_helper.dart';
import 'package:news_app/science/science_screen.dart';
import 'package:news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "أعمال"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "رياضة"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "علوم"),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getSportsNews();
    // } else if (index == 1) {
    //   getSportsNews();
    // } else {
    //   getScienceNews();
    // }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusinessNews() {
    emit(NewsBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getDate(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'e214eec6f1464578a3f026d7e2c8b736'
        },
      ).then(
        (value) {
          print(
            value.data.toString(),
          );
          business = value.data['articles'];
          print(business[0]['title']);
          emit(NewsBusinessSuccessState());
        },
      ).catchError(
        (onError) {
          print(
            onError.toString(),
          );
          emit(NewsBusinessErrorState(onError.toString()));
        },
      );
    } else {
      emit(NewsBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSportsNews() {
    emit(NewsSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getDate(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'e214eec6f1464578a3f026d7e2c8b736'
        },
      ).then(
        (value) {
          print(
            value.data.toString(),
          );
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsSportsSuccessState());
        },
      ).catchError(
        (onError) {
          print(
            onError.toString(),
          );
          emit(NewsSportsErrorState(onError.toString()));
        },
      );
    } else {
      emit(NewsSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScienceNews() {
    emit(NewsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getDate(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'e214eec6f1464578a3f026d7e2c8b736'
        },
      ).then(
        (value) {
          print(
            value.data.toString(),
          );
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsScienceSuccessState());
        },
      ).catchError(
        (onError) {
          print(
            onError.toString(),
          );
          emit(NewsScienceErrorState(onError.toString()));
        },
      );
    } else {
      emit(NewsScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearchedNews(String value) {
    emit(NewsScienceLoadingState());
    search = [];
    DioHelper.getDate(
      url: '/v2/everything',
      query: {'q': '$value', 'apiKey': 'e214eec6f1464578a3f026d7e2c8b736'},
    ).then(
      (value) {
        print(
          value.data.toString(),
        );
        search = value.data['articles'];
        print(search[0]['title']);
        emit(NewsSSearchSuccessState());
      },
    ).catchError(
      (onError) {
        print(
          onError.toString(),
        );
        emit(NewsSearchErrorState(onError.toString()));
      },
    );
  }

  bool isDark = false;
  void changeThemeMode() async {
    isDark = !isDark;
    await CacheHelper.putData(key: 'isDark', value: true);
    emit(ChangeThemeMode());
  }
}
