import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getx_wave_app/app/wave_app.dart';
import 'package:getx_wave_app/core/dependencies.dart';
import 'package:getx_wave_app/core/firebase_initialize.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  await dotenv.load(fileName: ".env");
  await DependencyInitializer.init();
  runApp(WaveApp());
}
