import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getx_wave_app/app/wave_app.dart';
import 'package:getx_wave_app/core/dependencies.dart';
import 'package:getx_wave_app/core/firebase_initialize.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await FirebaseInitializer.initialize();
  await dotenv.load();
  await DependencyInitializer.init();
  // Get.find<FirebaseSeeder>().seedDatabase();
  runApp(WaveApp());
}
