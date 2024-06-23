import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseid;
  Category category;
  DateTime date;
  int amount;

  Expense({
    required this.expenseid,
    required this.category,
    required this.date,
    required this.amount,
  });
   static final empty =
      Expense(expenseid: '', category: Category.empty, amount: 0, date: DateTime.now());

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseid,
      category: category,
      date: date,
      amount: amount,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
        expenseid: entity.expenseId,
        category: entity.category,
        date: entity.date,
        amount: entity.amount);
  }
}
