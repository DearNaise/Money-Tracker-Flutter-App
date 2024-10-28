import 'package:flutter/material.dart';
import 'package:checklist_app/model/add_amount.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> activities = [];

  List<Activity> get recentActivities => activities;

  // Track amounts
  int totalAmount = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  void addActivity(Activity activity) {
    if (!activities.contains(activity)) {
      activities.add(activity);
      totalAmount += activity.amount; // Update total amount

      if (activity.amount > 0) {
        totalIncome += activity.amount; // Update total income
      } else {
        totalExpense += activity.amount.abs(); // Update total expense
      }

      // Notify listeners of state changes
      notifyListeners();
    }
  }

  List<Activity> getRecentActivities() {
    return activities;
  }

  int calculateTotalAmount() => totalAmount;

  int calculateIncome() => totalIncome;

  int calculateExpense() => totalExpense;
}