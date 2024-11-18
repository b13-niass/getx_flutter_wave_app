import 'package:get/get.dart';
import 'package:getx_wave_app/core/firebase_initialize.dart';

class DependencyInitializer {
  static Future<void> init() async {
    Get.put(FirebaseInitializer.auth);

    Get.put(FirebaseInitializer.firestore);

    Get.put(FirebaseInitializer.storage);
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