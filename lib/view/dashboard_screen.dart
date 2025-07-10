
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';

import 'package:motofix_app/feature/customer_service/presentation/view_model/service_view_model.dart';
import 'package:motofix_app/feature/service/presentation/view/booking_view.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_view_model.dart';
import 'package:motofix_app/view/home_screen.dart';
import 'package:motofix_app/view/history_screen.dart';
import 'package:motofix_app/feature/auth/presentation/view/profile_screen.dart';

import '../app/cubit/bottom_navigation_cubit.dart';
import '../app/service_locator/service_locator.dart';

class MotoFixDashboard extends StatelessWidget {
  const MotoFixDashboard({super.key});

  // The list of screens is now clean, without any BlocProviders.
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const BookingView(), // No longer needs a local provider
    const HistoryScreen(),
    const ProfileViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // KEY CHANGE: Provide all BLoCs needed by the dashboard tabs here.
    return MultiBlocProvider(
      providers: [
        // A provider for our new navigation cubit
        BlocProvider(
          create: (_) => BottomNavigationCubit(),
        ),
        // Provide the ServiceViewModel for the HomeScreen
        BlocProvider<ServiceViewModel>.value(
          value: serviceLocator<ServiceViewModel>(),
        ),
        // Provide the BookingViewModel for the BookingView (Activities)
        BlocProvider<BookingViewModel>.value(
          value: serviceLocator<BookingViewModel>(),
        ),

        BlocProvider<ProfileViewModel>.value(value: serviceLocator<ProfileViewModel>()) ,
      ],
      // The child is a builder that listens to navigation changes
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            backgroundColor: const Color(0xFF2A4759),
            body: IndexedStack(
              index: selectedIndex,
              children: _widgetOptions,
            ),
            bottomNavigationBar: _buildBottomNavigationBar(
              context,
              selectedIndex,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int selectedIndex) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2A4759),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      currentIndex: selectedIndex,
      onTap: (index) {
        // Use the cubit to change the tab
        context.read<BottomNavigationCubit>().changeTab(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}