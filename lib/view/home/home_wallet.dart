import 'package:flutter/material.dart';
import 'package:checklist_app/provider/activity_provider.dart';
import 'package:checklist_app/widget_style/widget_color.dart';

class WalletBox extends StatelessWidget {
  final ActivityProvider activityProvider;
  final WidgetColor myColor;

  WalletBox({required this.activityProvider, required this.myColor});

  @override
  Widget build(BuildContext context) {
    // Wallet Box
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        color: myColor.homeBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.shade300,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'My Wallet',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${activityProvider.calculateTotalAmount()} K',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncomeInfo(context),
                _buildExpenseInfo(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeInfo(BuildContext context) {
    return Row(
      children: [
        _buildIconBox(Icons.arrow_upward_rounded),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${activityProvider.calculateIncome()} K',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpenseInfo(BuildContext context) {
    return Row(
      children: [
        _buildIconBox(Icons.arrow_downward_rounded),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expenses',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${activityProvider.calculateExpense()} K',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconBox(IconData icon) {
    return Container(
      width: 40,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 13,
        ),
      ),
    );
  }
}
