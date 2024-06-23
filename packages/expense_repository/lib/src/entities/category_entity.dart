

class CategoryEntity {
  String categoryid;
  String name;
  int totalExpenses;
  String icon;
  int color;

  CategoryEntity(
      {required this.categoryid,
      required this.name,
      required this.totalExpenses,
      required this.color,
      required this.icon});

  Map<String, Object?> toDocument() {
    return {
      'categoryid': categoryid,
      'name': name,
      'totalExpenses': totalExpenses,
      'color': color,
      'icon': icon,
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
        categoryid: doc['categoryid'],
        name: doc['name'],
        totalExpenses: doc['totalExpenses'],
        color: doc['color'],
        icon: doc['icon']);
  }
}
