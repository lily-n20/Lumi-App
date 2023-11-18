import 'package:lumi/datetime/date_time_helper.dart';
import 'package:lumi/models/expense_item.dart';

class ExpenseData {
  //list of ALL expense
  List<ExpenseItem> overallExpenseList = [];

  //method to get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }
  //method to add expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }
  
  //method to delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
  }

  //method to get weekday from a datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //method to get date for start of week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get current date
    DateTime today = DateTime.now();

    //go backward to find sunday
    for (int i = 0 ; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  /*

  convert overall list of expense into a daily expense summary

  e.g.

  overallExpenseList = 

  [
    [food, 2023/01/30, $10],
    [food, 2023/02/30, $10],
    [food, 2023/03/30, $10],
    [food, 2023/04/30, $10],
    [food, 2023/05/30, $10],
    [food, 2023/01/30, $10],
    [food, 2023/01/30, $10],
  ]

  -> 

  Daily Expense Summary = 

  [
    [//day: // summary total for that day]
    [//day: // summary total for that day]
    [//day: // summary total for that day]
  ]
  */

  //DSA -> use mape to store transactions

  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {
      //date(yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;

      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}