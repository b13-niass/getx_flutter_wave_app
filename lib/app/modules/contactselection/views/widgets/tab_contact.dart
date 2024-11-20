import 'package:flutter/material.dart';
import 'package:getx_wave_app/core/theme/colors.dart';

class TabContactWidget extends StatelessWidget {
  final String title;
  final String tab;
  final String activeTab;
  final Function(String) updateParentTab;

  const TabContactWidget({
    required this.title,
    required this.tab,
    required this.activeTab,
    required this.updateParentTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = activeTab == tab;

    return Expanded(
      child: InkWell(
        onTap: () {
          updateParentTab(tab);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.secondary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? AppColors.secondary : Colors.black54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
