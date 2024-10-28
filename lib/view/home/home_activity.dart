import 'package:flutter/material.dart';
import 'package:checklist_app/model/add_amount.dart';
import 'package:checklist_app/provider/activity_provider.dart';
import 'package:checklist_app/widget_style/widget_color.dart';

// Decorator pattern
class ActivityDecorator extends StatelessWidget {
  final Activity activity;
  final WidgetColor myColor;

  ActivityDecorator({required this.activity, required this.myColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.shade300,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActivityDetails(context, activity),
            _buildActivityAmount(context, activity),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityDetails(BuildContext context, Activity activity) {
    // Customize details here
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: myColor.activityColor,
                shape: BoxShape.circle,
              ),
            ),
            Image.asset(
              'assets/icons/${CategoryIcon.getIcon(activity.category)}.png',
              scale: 20,
              color: Colors.white,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              activity.description,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityAmount(BuildContext context, Activity activity) {
    // Customize amount display here
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${activity.amount} K',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class RecentActivityList extends StatelessWidget {
  final ActivityProvider activityProvider;
  final WidgetColor myColor;

  RecentActivityList({required this.activityProvider, required this.myColor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activityProvider.recentActivities.length,
      itemBuilder: (context, index) {
        final activity = activityProvider.recentActivities[index];
        return _buildActivityItem(context, activity);
      },
    );
  }

  Widget _buildActivityItem(BuildContext context, Activity activity) {
    return ActivityDecorator(
      activity: activity,
      myColor: myColor,
    );
  }
}
