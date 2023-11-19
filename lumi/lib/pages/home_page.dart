import 'package:flutter/material.dart';
import 'package:lumi/components/expense_summary.dart';
import 'package:lumi/components/expense_tile.dart';
import 'package:lumi/data/expense_data.dart';
import 'package:lumi/models/expense_item.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //prepare data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }
  //add new expense
  void addNewExpense() {
    //a
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: 'Expense name',
              )
            ),

            //expense amount

            Row( 
              children: [
                //dollars
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                hintText: 'Dollars',
              )
                  ),
                ),
                //Cents
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                hintText: 'Cents',
              )
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),

          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),

        ],
      ), 
    );
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }


  //save method
  void save() {
    //only savev if all fields are filled
    if (newExpenseNameController.text.isNotEmpty && 
        newExpenseDollarController.text.isNotEmpty &&
        newExpenseCentsController.text.isNotEmpty) {
        
        //put dollars and cents together
        String amount = '${newExpenseDollarController.text}.${newExpenseCentsController.text}';
        //create expense item
        ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now(),
        );

        //add the new expense
        Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

  //cancel method
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData> (
      builder:  (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 255, 198),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Color.fromARGB(255, 13, 64, 8),
          child: Icon(Icons.add),
        ),

        //display expenses back in a list
        body: ListView(children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            
            const SizedBox(height: 20),

            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,   
                deleteTapped: (p0) => 
                  deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
        ]),
      ),
    );
  }
}
