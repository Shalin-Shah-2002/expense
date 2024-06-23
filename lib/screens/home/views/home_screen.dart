import 'package:expense/screens/add_expense/blocs/Create_Expenseboc/create_expense_bloc.dart';
import 'package:expense/screens/add_expense/blocs/Create_categorybloc/create_category_bloc.dart';
import 'package:expense/screens/add_expense/blocs/get_categoriesbloc/get_categories_bloc.dart';
import 'package:expense/screens/add_expense/views/add_expense.dart';
import 'package:expense/screens/home/views/main_screen.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense/screens/home/views/stats/stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color selecteditem = Colors.blue;
  Color unselecteditem = Colors.blueGrey;

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 3,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selecteditem : unselecteditem,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.graph_circle_fill,
                  color: index == 1 ? selecteditem : unselecteditem,
                ),
                label: 'Status',
              )
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ], transform: const GradientRotation(-4))),
          child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CreateCategoryBloc(
                              FirebaseExpenseRepo(),
                            ),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetCategoriesBloc(FirebaseExpenseRepo())..add(GetCategories()),
                          ),
                             BlocProvider(
                            create: (context) => CreateExpenseBloc(
                              FirebaseExpenseRepo(),
                            ),
                          ),
                        ],
                        child: const AddExpense(),
                      ),
                    ));
              },
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              child: const Icon(CupertinoIcons.plus)),
        ),
        body: index == 0 ? const MainScreen() : const StatsScreen());
  }
}
