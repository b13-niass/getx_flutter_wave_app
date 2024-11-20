import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/modules/planificationliste/controllers/planificationliste_controller.dart';
import 'package:getx_wave_app/app/modules/planificationliste/views/witgets/planification_card.dart';

class PlanificationlistView extends GetView<PlanificationlistController> {
  const PlanificationlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Planifications'),
        backgroundColor: const Color(0xFF4749D5), // Use theme color
      ),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        if (GlobalState.planifications.isEmpty) {
          return const Center(
            child: Text('Aucune planification disponible.'),
          );
        }

        return Obx(() => ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: GlobalState.planifications.length,
          itemBuilder: (context, index) {
            final planification = GlobalState.planifications[index];
            return PlanificationCard(
              planification: planification,
              onCancel: () => controller.cancelPlanification(planification),
            );
          },
        ));
      }),
    );
  }
}
