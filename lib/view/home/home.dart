import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checklist_app/model/add_amount.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/view/home/add_activity.dart';
import 'package:checklist_app/provider/activity_provider.dart';
import 'package:checklist_app/view/home/home_wallet.dart';
import 'package:checklist_app/view/home/home_activity.dart';

class HomePage extends StatelessWidget {
  final WidgetColor myColor = WidgetColor();

  @override
  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityProvider>(context);

    return Scaffold(

      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColor.buttonColor,
        onPressed: () {
          _showAddActivityDialog(context, activityProvider);
        },
        child: Image.asset("assets/icons/pen.png", width: 22),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              // home_wallet
              WalletBox(activityProvider: activityProvider, myColor: myColor),
              const SizedBox(height: 30),
              _buildRecentActivityHeader(context),
              const SizedBox(height: 20),

              // home_activity
              Expanded(
                child: RecentActivityList(activityProvider: activityProvider, myColor: myColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context, ActivityProvider activityProvider) {
    showDialog(
      context: context,
      builder: (context) => AddActivityDialog(
        onActivityAdded: (Activity activity) {
          activityProvider.addActivity(activity);
        },
      ),
    );
  }

  Widget _buildRecentActivityHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      //Recent activity title
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Define an action if needed
          },
          child: const Text(
            'All',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
