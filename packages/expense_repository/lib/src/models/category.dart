import 'package:expense_repository/src/entities/entities.dart';

class Category {
  String categoryid;
  String name;
  int totalExpenses;
  String icon;
  int color;

  Category(
      {required this.categoryid,
      required this.name,
      required this.totalExpenses,
      required this.color,
      required this.icon});

  static final empty =
      Category(categoryid: '', name: '', totalExpenses: 0, color: 0, icon: '');

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryid: categoryid,
      name: name,
      totalExpenses: totalExpenses,
      icon: icon,
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryid: entity.categoryid,
      name: entity.name,
      totalExpenses: entity.totalExpenses,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
