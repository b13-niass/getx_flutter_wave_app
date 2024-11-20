import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/modules/home/views/widgets/button_action_widget.dart';
import 'package:getx_wave_app/app/modules/home/views/widgets/transaction_line_widget.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            );
          }

          // final UserModel? user = controller.user.value;
          // final solde = controller.user.value?.wallet?.solde;
          // final transactions = controller.user.value?.transactions;

          return SingleChildScrollView(
            child: Column(
              children: [
                // App Bar Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info_outline_rounded, color: AppColors.dark),
                      onPressed: () {
                        Get.toNamed('/planificationliste');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppColors.dark),
                      onPressed: () async {
                        await controller.authService.logout();
                        Get.offAllNamed('/login');
                      },
                    ),
                  ],
                ),

                // Balance Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.isHidden.value)
                      ...List.generate(
                        8,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.dark,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    else
                     Obx(() => Text(
                        '${GlobalState.solde.value.round()} Fcfa',
                        style: AppTextStyles.heading.copyWith(color: AppColors.dark),
                      )),
                    IconButton(
                      icon: Icon(
                        controller.isHidden.value
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        color: AppColors.dark,
                      ),
                      onPressed: () {
                        controller.isHidden.toggle();
                      },
                    ),
                  ],
                ),

                // QR Code Display
                Obx(() {
                  if (GlobalState.qrCode.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No QR code available.', style: AppTextStyles.body),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: QrImageView(
                        data: GlobalState.qrCode.value,
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: AppColors.primaryBackground,
                      ),
                    );
                  }
                }),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (GlobalState.user.value?.role!.name == "CLIENT") ...[
                      ButtonActionWidget(label: 'Transfert', icon: Icons.person),
                      const SizedBox(width: 24),
                      ButtonActionWidget(label: 'Planifier', icon: Icons.calendar_month),
                      const SizedBox(width: 24),
                      ButtonActionWidget(label: 'Multi Transfert', icon: Icons.multiple_stop),
                    ] else ...[
                      ButtonActionWidget(label: 'Depot', icon: Icons.add_circle_outline),
                      const SizedBox(width: 24),
                      ButtonActionWidget(label: 'Retrait', icon: Icons.remove_circle_outline),
                      const SizedBox(width: 24),
                      ButtonActionWidget(label: 'Déplafonnement', icon: Icons.arrow_upward),
                    ],
                  ],
                ),

                // Transactions List
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Obx( () => GlobalState.transactions.isNotEmpty
                      ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: GlobalState.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = GlobalState.transactions[index];
                      final title = transaction.typeTransaction!.name;
                      final date = controller.formatDateToFrench(transaction.createdAt.toString());
                      final amount = title == "TRANSFERT" || title == "RETRAIT"
                          ? "-${transaction.montantEnvoye.round().toString()}"
                          : transaction.montantEnvoye.round().toString();
                      return TransactionLineWidget(
                        title: transaction.typeTransaction!.name,
                        date: date,
                        amount: amount,
                        transaction: transaction,
                      );
                    },
                  )
                      : const Center(
                    child: Text(
                      'Aucune transaction disponible.',
                      style: AppTextStyles.body,
                    ),
                  ),
                ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
