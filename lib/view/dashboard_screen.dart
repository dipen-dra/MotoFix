// lib/view/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motofix_app/feature/service/presentation/view/booking_view.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_view_model.dart';
// Import the new screen files
import 'package:motofix_app/view/home_screen.dart';
import 'package:motofix_app/view/activities_screen.dart';
import 'package:motofix_app/view/history_screen.dart';
import 'package:motofix_app/view/profile_screen.dart';

import '../app/service_locator/service_locator.dart';

class MotoFixDashboard extends StatefulWidget {
  const MotoFixDashboard({super.key});

  @override
  State<MotoFixDashboard> createState() => _MotoFixDashboardState();
}

class _MotoFixDashboardState extends State<MotoFixDashboard> {
  int _selectedIndex = 0; // Manages the current selected tab

  // List of widgets (screens) to display for each navigation item
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),

    BlocProvider<BookingViewModel>.value(
      value: serviceLocator<BookingViewModel>(),
      child: const BookingView(),
    ),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2A4759),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed, // Ensures all labels are shown
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      currentIndex: _selectedIndex, // Set the current selected index
      onTap: _onItemTapped, // Handle tap events
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
          icon: Icon(FontAwesomeIcons.history), // Using FontAwesome for history
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