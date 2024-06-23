import 'package:expense/screens/add_expense/blocs/Create_categorybloc/create_category_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

GetCategoryCreation(BuildContext context) {
  List<Icon> wigets = [
    const Icon(
      Icons.flight,
      color: Colors.grey,
    ),
    const Icon(Icons.movie_creation, color: Colors.grey),
    const Icon(FontAwesomeIcons.burger, color: Colors.grey),
    const Icon(Icons.shopping_bag, color: Colors.grey),
    const Icon(FontAwesomeIcons.phone, color: Colors.grey),
    const Icon(Icons.home_filled, color: Colors.grey),
    const Icon(Icons.pets, color: Colors.grey)
  ];
  Icon? iconselected;
  Color showPickedColor = Colors.white;
  return showDialog(
    context: context,
    builder: (ctx) {
      bool isLoading = false;
      bool isExpended = false;
      var changeBorderRadius = BorderRadius.circular(12);
      TextEditingController categoryNamecontroller = TextEditingController();
      TextEditingController categoryIconcontroller = TextEditingController();

      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx);
                } else if (state is CreateCategoryLodaing) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Create a Category",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: categoryNamecontroller,
                        textAlignVertical: TextAlignVertical.center,
                        // // readOnly: true,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Name",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: categoryIconcontroller,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: iconselected,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isExpended = !isExpended;
                                  });
                                },
                                icon: const Icon(CupertinoIcons.chevron_down)),
                            hintText: "Icon",
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: isExpended
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))
                                    : changeBorderRadius)),
                      ),
                      isExpended != false
                          ? Container(
                              height: 200,
                              width: 300,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(12)),
                                  color: Colors.white),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: wigets.length,
                                itemBuilder: (context, int i) {
                                  // this wo uld be me whobuild thsi list view

                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          iconselected = wigets[i];
                                        });
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 35,
                                        child: wigets[i],
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 3,
                                                color: iconselected == wigets[i]
                                                    ? Colors.blueAccent
                                                    : Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),

                      // this FormField is used for colorpicker
                      TextFormField(
                        controller: categoryIconcontroller,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                  // title: Text('Pick a color!'),
                                  content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Pick a Color!!",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: Colors.black,
                                      onColorChanged: (value) {
                                        setState(
                                          () {
                                            showPickedColor = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            print(showPickedColor);
                                          },
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )))
                                ],
                              ));
                            },
                          );
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Color",
                            filled: true,
                            isDense: true,
                            fillColor: showPickedColor,
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
                          child: isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  onPressed: () {
                                    setState(
                                      () {
                                        isLoading = true;
                                      },
                                    );
                                    Category category = Category.empty;
                                    category.categoryid = const Uuid().v1();
                                    category.name = categoryNamecontroller.text;
                                    category.icon = iconselected.toString();
                                    category.color = showPickedColor.value;
                                    context
                                        .read<CreateCategoryBloc>()
                                        .add(CreateCategory(category));

                                    // Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Ok!!",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  )))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
