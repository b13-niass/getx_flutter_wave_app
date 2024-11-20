import 'package:get/get.dart';

import '../modules/codesecret/bindings/codesecret_binding.dart';
import '../modules/codesecret/views/codesecret_view.dart';
import '../modules/contactplanification/bindings/contactplanification_binding.dart';
import '../modules/contactplanification/views/contactplanification_view.dart';
import '../modules/contactselection/bindings/contactselection_binding.dart';
import '../modules/contactselection/views/contactselection_view.dart';
import '../modules/contactselection_multiple/bindings/contactselection_multiple_binding.dart';
import '../modules/contactselection_multiple/views/contactselection_multiple_view.dart';
import '../modules/depot/bindings/depot_binding.dart';
import '../modules/depot/views/depot_view.dart';
import '../modules/depot_scan/bindings/depot_scan_binding.dart';
import '../modules/depot_scan/views/depot_scan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/planification/bindings/planification_binding.dart';
import '../modules/planification/views/planification_view.dart';
import '../modules/planificationliste/bindings/planificationliste_binding.dart';
import '../modules/planificationliste/views/planificationliste_view.dart';
import '../modules/qrscanner/bindings/qrscanner_binding.dart';
import '../modules/qrscanner/views/qrscanner_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/transactiondetail/bindings/transactiondetail_binding.dart';
import '../modules/transactiondetail/views/transactiondetail_view.dart';
import '../modules/transfertcontact/bindings/transfertcontact_binding.dart';
import '../modules/transfertcontact/views/transfertcontact_view.dart';
import '../modules/transfertmultiple/bindings/transfertmultiple_binding.dart';
import '../modules/transfertmultiple/views/transfertmultiple_view.dart';
import '../modules/verification_code/bindings/verification_code_binding.dart';
import '../modules/verification_code/views/verification_code_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_CODE,
      page: () => VerificationCodeView(),
      binding: VerificationCodeBinding(),
    ),
    GetPage(
      name: _Paths.CODESECRET,
      page: () => const CodesecretView(),
      binding: CodesecretBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTSELECTION,
      page: () => const ContactSelectionView(),
      binding: ContactselectionBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTPLANIFICATION,
      page: () => const ContactplanificationView(),
      binding: ContactplanificationBinding(),
    ),
    GetPage(
      name: _Paths.QRSCANNER,
      page: () => const QrscannerView(),
      binding: QrscannerBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFERTCONTACT,
      page: () => const TransfertcontactView(),
      binding: TransfertcontactBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFERTMULTIPLE,
      page: () => const TransfertmultipleView(),
      binding: TransfertmultipleBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONDETAIL,
      page: () => const TransactiondetailView(),
      binding: TransactiondetailBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTSELECTION_MULTIPLE,
      page: () => const ContactselectionMultipleView(),
      binding: ContactselectionMultipleBinding(),
    ),
    GetPage(
      name: _Paths.PLANIFICATION,
      page: () => const PlanificationView(),
      binding: PlanificationBinding(),
    ),
    GetPage(
      name: _Paths.PLANIFICATIONLISTE,
      page: () => const PlanificationlistView(),
      binding: PlanificationlisteBinding(),
    ),
    GetPage(
      name: _Paths.DEPOT_SCAN,
      page: () => const DepotScanView(),
      binding: DepotScanBinding(),
    ),
    GetPage(
      name: _Paths.DEPOT,
      page: () => const DepotView(),
      binding: DepotBinding(),
    ),
  ];
}
