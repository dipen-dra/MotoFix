import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_view_model.dart';
import 'package:motofix_app/view/activities_screen.dart';
import 'package:motofix_app/view/history_screen.dart';
import 'package:motofix_app/view/home_screen.dart';
import 'package:motofix_app/view/profile_screen.dart';

import '../service_locator/service_locator.dart';


class BottomNavigationState {
  final int currentIndex;
  final List<Widget> screens;

  BottomNavigationState({required this.currentIndex})
      : screens = [
    const HomeScreen() ,
    // TrailView(),
    BlocProvider<BookingViewModel>.value(
      value: serviceLocator<BookingViewModel>(),
      child: ActivitiesScreen(),
    ),
    HistoryScreen(),
    ProfileScreen(),
  ];

  Widget get currentScreen => screens[currentIndex];
}