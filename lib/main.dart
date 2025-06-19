import 'package:flutter/material.dart';
import 'package:motofix_app/app/service_locator/service_locator.dart';
import 'package:motofix_app/core/network/hive_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init Hive service
  await HiveService().init();
  await initDependencies();

  runApp(MyApp());
}
