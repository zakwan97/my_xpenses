import 'package:get/get.dart';
import 'package:my_xpenses/database/database_helper.dart';
import 'package:my_xpenses/model/expense_model.dart';

class ExpensesController extends GetxController {
  final RxList expensesList = <ExpenseModel>[].obs;

  Future<void> getExpenses() async {
    final List<Map<String, dynamic>> exp = await DBHelper().queryAllRows();
    expensesList
        .assignAll(exp.map((data) => ExpenseModel.fromMap(data)).toList());
  }

  Future<void> getExpensesbyId(int id) async {
    await DBHelper().getExpenseByID(id);
    getExpenses();
  }

  addExpenses(ExpenseModel exp) async {
    await DBHelper().createExpenses(exp);
    expensesList.add(exp);
    getExpenses();
  }

  deleteExpenses(int? id) async {
    await DBHelper().delete(id!);
    getExpenses();
  }

  deleteAllExpenses() async {
    await DBHelper().deleteAllTasks();
    getExpenses();
  }

  markAsCompleted(int? id) async {
    await DBHelper().update(id!);
    getExpenses();
  }
}
