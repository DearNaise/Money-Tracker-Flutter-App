// to add activity when click on floating action button
class Activity {
  final String title;
  final String description;
  final String category;
  final int amount;

  Activity({
    required this.title,
    required this.description,
    required this.category,
    required this.amount,
  });
}

class CategoryIcon {
  static String getIcon(String category) {
    switch (category) {
      case 'Food':
        return 'food';
      case 'Health':
        return 'health';
      case 'Education':
        return 'education';
      case 'Pocket Money':
        return 'pocket';
      case 'Salary':
        return 'salary';
      case 'Shopping':
        return 'shop';
      case 'Other':
        return 'other';
      default:
        return '';
    }
  }
}
