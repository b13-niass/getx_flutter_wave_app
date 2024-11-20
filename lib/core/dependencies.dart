import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/fire_base_seeder.dart';
import 'package:getx_wave_app/core/firebase_initialize.dart';

class DependencyInitializer {
  static Future<void> init() async {
    Get.put(FirebaseInitializer.auth);

    Get.put(FirebaseInitializer.firestore);

    Get.put(FirebaseInitializer.storage);

    Get.put<FirebaseSeeder>(
        FirebaseSeeder(
          Get.find<FirebaseFirestore>()
      )
    );
  }
}


// // // Services (Singletons)
// Get.put<HttpService>(HttpServiceImpl());
// Get.put<AuthService>(
//     AuthServiceImpl(
//           Get.find<HttpService>()
//       )
// );
//
// Get.put<ClientService>(
//     ClientServiceImpl(
//         Get.find<HttpService>()
//     )
// );