import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motofix_app/app/cubit/bottom_navigation_cubit.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DashboardGyroHandler {
  final BuildContext context;

  StreamSubscription? _gyroSub;
  bool _gyroTriggered = false;

  DashboardGyroHandler({
    required this.context,
  });

  void startListening() {
    _gyroSub = gyroscopeEvents.listen(_onGyroscope);
  }


  void dispose() {
    _gyroSub?.cancel();
  }

  void _onGyroscope(GyroscopeEvent event) {
    const rotationThreshold = 4.0;

    if (!_gyroTriggered &&
        (event.x.abs() > rotationThreshold ||
            event.y.abs() > rotationThreshold)) {
      _gyroTriggered = true; 

      final cubit = context.read<BottomNavigationCubit>();
      final currentIndex = cubit.state;
      const screenCount = 4; // The total number of tabs.
      final nextIndex = (currentIndex + 1) % screenCount;

      cubit.changeTab(nextIndex);

      // Provide visual feedback to the user.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Switched to next tab!'),
          duration: Duration(seconds: 1),
        ),
      );

      // Reset the debounce flag after a 1.5-second cooldown period.
      Future.delayed(const Duration(milliseconds: 1500), () {
        _gyroTriggered = false;
      });
    }
  }
}
