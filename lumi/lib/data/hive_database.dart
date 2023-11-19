import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDataBase {
  //reference box opened in main.dart
  final _myBox = Hive.box('expense_database2');

  //write data
  void saveData(List<ExpenseItem> allExpense) {
    /*

    Hive can only store strings and datetime, not custom objects like expense item
    convert expense item objects into types tht can be stored in db

    all expense = 

    [
      ExpenseItem (name / amount / date)
    ]

    -> 

    [
      [name, amount, date],
      ..
    ]

    */

    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];  
      allExpenseFormatted.add(expenseFormatted);
    }



    //store in database
    _myBox.put('ALL_EXPENSES', allExpenseFormatted);
  }

  //read data
  List<ExpenseItem> readData() {
    /*
    
    Data is stored in Hive as a list of strings + dateTime
    convert saved data back into expense item objects

    savedData = 

    [

      [name, amount, date],
      ...
    ]

    -> 

    [

      ExpenseItem (name / amount / date),
      ..

    ]

    */

    List savedExpense = _myBox.get('ALL_EXPENSES') ?? [];
    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedExpense.length; i++) {
      String name = savedExpense[i][0];
      String amount =  savedExpense[i][1];
      DateTime dateTime = savedExpense[i][2];

      //create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpense.add(expense);
    } 

    return allExpense;
  }
}

