import 'package:flutter/material.dart';

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
    return Expanded(
      child: GestureDetector(
        onTap: () => updateParentTab(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: activeTab == tab ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: activeTab == tab ? Colors.black : Colors.grey,
                fontWeight:
                activeTab == tab ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
