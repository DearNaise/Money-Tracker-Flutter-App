import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checklist_app/model/add_amount.dart';
import 'package:checklist_app/provider/activity_provider.dart';
import 'package:checklist_app/widget_style/widget_color.dart';

class AddActivityDialog extends StatefulWidget {
  final Function(Activity) onActivityAdded;

  const AddActivityDialog({
    Key? key,
    required this.onActivityAdded,
  }) : super(key: key);

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  WidgetColor myColor = WidgetColor();
  String _activityType = 'Income';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Pocket Money';
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'What changed in your wallet today?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _activityType = 'Income';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activityType == 'Income' ? myColor.activityColor : Colors.white38,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Income',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _activityType = 'Expense';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activityType == 'Expense' ? myColor.activityColor : Colors.white38,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Expense',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Pocket Money',
                  'Salary',
                  'Food',
                  'Health',
                  'Education',
                  'Shopping',
                  'Other',
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/${CategoryIcon.getIcon(value)}.png',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 10),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final amount = int.tryParse(_amountController.text);
                      if (amount != null) {
                        final activity = Activity(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          category: _selectedCategory,
                          amount: _activityType == 'Expense' ? -amount : amount,
                        );

                        // Use the provider to add the activity
                        final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
                        activityProvider.addActivity(activity);
                        widget.onActivityAdded(activity); // Call the callback

                        // Close the dialog
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
