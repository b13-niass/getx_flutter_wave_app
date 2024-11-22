import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import '../controllers/transactiondetail_controller.dart';

class TransactiondetailView extends GetView<TransactiondetailController> {
  const TransactiondetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionModel? transaction = controller.transaction;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails de la Transaction',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primaryLight,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryLight.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildStatusCard(transaction),
                  const SizedBox(height: 24),
                  _buildDetailsCard(transaction),
                  const SizedBox(height: 24),
                  _buildActionButtons(transaction),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(TransactionModel? transaction) {
    final statusColor = transaction?.etatTransaction?.name == 'EFFECTUER'
        ? Colors.green
        : Colors.red;

    return Card(
      elevation: 8,
      shadowColor: statusColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              statusColor.withOpacity(0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              transaction?.etatTransaction?.name == 'EFFECTUER'
                  ? Icons.check_circle_outline
                  : Icons.error_outline,
              color: statusColor,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              '${transaction?.typeTransaction?.name}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${transaction?.etatTransaction?.name}',
              style: TextStyle(
                fontSize: 18,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(TransactionModel? transaction) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détails de la Transaction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              'Montant Envoyé',
              '${transaction?.montantEnvoye.toStringAsFixed(2)} F',
              Icons.arrow_upward,
              Colors.red,
            ),
            _buildDetailRow(
              'Montant Reçu',
              '${transaction?.montantRecus.toStringAsFixed(2)} F',
              Icons.arrow_downward,
              Colors.green,
            ),
            _buildDetailRow(
              'Créé le',
              transaction?.createdAt?.toLocal().toString().substring(0, 19) ?? '',
              Icons.access_time,
              AppColors.secondary,
            ),
            if (transaction?.deletedAt != null)
              _buildDetailRow(
                'Supprimé le',
                transaction?.deletedAt.toString() ?? '',
                Icons.delete_outline,
                Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.dark.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(TransactionModel? transaction) {
    return Column(
      children: [
        if (controller.showCancelButton(transaction))
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:() => controller.cancelTransaction(transaction!.id!),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Annuler la Transaction'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}