import 'package:expense/screens/add_expense/blocs/Create_Expenseboc/create_expense_bloc.dart';
import 'package:expense/screens/add_expense/blocs/get_categoriesbloc/get_categories_bloc.dart';
import 'package:expense/screens/add_expense/views/category_creation.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // List<Icon> wigets = [
  //   const Icon(
  //     Icons.flight,
  //     color: Colors.grey,
  //   ),
  //   const Icon(Icons.movie_creation, color: Colors.grey),
  //   const Icon(FontAwesomeIcons.burger, color: Colors.grey),
  //   const Icon(Icons.shopping_bag, color: Colors.grey),
  //   const Icon(FontAwesomeIcons.phone, color: Colors.grey),
  //   const Icon(Icons.home_filled, color: Colors.grey),
  //   const Icon(Icons.pets, color: Colors.grey)
  // ];
  // all variables////
  TextEditingController expensecontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isexpand = false;
  late Expense expense;
  bool isloading = false;
  // this below initstate method is used for picking date
  // there is no need for this initstate funtion this function just returns the defult now date which is alredy selected by datepicker method
  @override
  void initState() {
    datecontroller.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
    expense = Expense.empty;
    expense.expenseid=const Uuid().v1();
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case "Icon(IconData(U+0F095), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return FontAwesomeIcons.phone;
      case "Icon(IconData(U+0E4A1), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return Icons.pets;
      case "Icon(IconData(U+0F805), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return FontAwesomeIcons.burger;
      case "Icon(IconData(U+0E297), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return Icons.flight;
      case "Icon(IconData(U+0E319), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return Icons.home_filled;
      case "Icon(IconData(U+0E40E), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return Icons.movie_creation;
      case "Icon(IconData(U+0E59A), color: MaterialColor(primary value: Color(0xff9e9e9e)))":
        return Icons.shopping_bag;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isloading = true;
          });
        }
      },
      child: GestureDetector(
        // this bellow widget is used to unfocused from focused wideget or TextFormField but
        // before that we have to wrap the scafold widget with the GestureDetector

        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Add Expenses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),

                //input field for amount addition
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: expensecontroller,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: const Text(
                          "Amount",
                          style: TextStyle(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(FontAwesomeIcons.rupeeSign,
                            size: 16, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // input field for Category
                TextFormField(
                  onTap: () {
                    setState(() {
                      isexpand = !isexpand;
                    });
                  },
                  readOnly: true,
                  controller: categorycontroller,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Category",
                      filled: true,
                      fillColor: expense.category == Category.empty
                          ? Colors.white
                          : Color(expense.category.color),
                      prefixIcon: expense.category == Category.empty
                          ? const Icon(FontAwesomeIcons.list,
                              size: 16, color: Colors.grey)
                          : Icon(getIconData(expense.category.icon)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          GetCategoryCreation(context);
                        },
                        icon: const Icon(FontAwesomeIcons.add,
                            size: 16, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: isexpand
                              ? const BorderRadius.vertical(
                                  top: Radius.circular(12))
                              : BorderRadius.circular(12))),
                ),
                isexpand
                    ? Container(
                        height: 200,
                        width: 400,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12))),
                        child:
                            BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                                builder: (context, state) {
                          if (state is GetCategoriesSuccess) {
                            return ListView.builder(
                              itemCount: state.categories.length,
                              itemBuilder: (context, int i) {
                                return Card(
                                    child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = state.categories[i];
                                      categorycontroller.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Icon(
                                      getIconData(state.categories[i].icon)),
                                  title: Text(state.categories[i].name),
                                  tileColor: Color(state.categories[i].color),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ));
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                      )
                    : Container(),

                const SizedBox(height: 20),
                // input field for datepicker

                TextFormField(
                  controller: datecontroller,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));
                    if (newDate != null) {
                      setState(() {
                        datecontroller.text =
                            DateFormat('dd/MM/yyyy').format(newDate);
                        selectedDate = newDate;
                        expense.date = newDate;
                      });
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Date",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(FontAwesomeIcons.calendar,
                          size: 16, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12))),
                ),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: isloading
                        ? const Center(child: const CircularProgressIndicator())
                        : TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              setState(() {
                                expense.amount =
                                    int.parse(expensecontroller.text);
                              });
                              context
                                  .read<CreateExpenseBloc>()
                                  .add(CreateExpense(expense));
                            },
                            child: const Text(
                              "Add",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// 2:15:15
