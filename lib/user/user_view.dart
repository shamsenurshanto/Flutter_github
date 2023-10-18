import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:my_app/user/user_controller.dart';

class user_model extends StatefulWidget {
  const user_model({super.key});

  @override
  State<user_model> createState() => _user_modelState();
}

var page_no = 1;
var page_no_label = 1;
var matched = 0;

class _user_modelState extends State<user_model> {
  @override
  ScrollController _controller = ScrollController();
  TextEditingController _controller_search = TextEditingController();

  void _scrollListener() {
    // Check if we've reached the bottom
    print("sjhsj");
    if (_controller.position.pixels < _controller.position.maxScrollExtent) {
      refresh_status = 1;
    }

    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      // Bottom of the list is reached

      page_no = page_no + 1;
      // page_no_label += 1;
      // GetDataApi();
      print('Reached the bottom!');
      useController.fetch_github(page_no);
      // useController.fetch_github_label(page_no_label);
      refresh_status = 0;
    }
    if (_controller.position.pixels == _controller.position.maxScrollExtent && matched == 1) {
    } else {
      print("notijg");
    }
    setState(() {});
  }

  //filter functions with every item added in list
  void Filter_function(var index) {
    if (useController.userListforGitLabelAdded.length == 0) {
      matched = 1;
    } else {
      for (int i = 0; i < useController.userListforGitLabelAdded.length; i++) {
        matched = 0;

        // issues name

        for (int j = 0; j < useController.userList[index].labels.length; j++) {
          String filter = useController.userListforGitLabelAdded[i];

          String label_name = useController.userList[index].labels[j].name.toString();

          if (label_name.toLowerCase().contains(filter.toLowerCase())) {
            matched = 1;
            break;
          }
        }
        if (matched == 0) break;
      }
    }
  }

  // date
  String Return_month(String input) {
    // Perform some modifications to the input string
    String modifiedString = input.toUpperCase() + " (Modified)";
    final dateString = input;

    final dateTime = DateTime.parse(dateString);
    final month = DateFormat('MMM').format(dateTime);

    //print('Month: $month');

    return month;
  }

  /// Returns:
  ///   the year extracted from the input string.
  String Return_Year(String input) {
    // Perform some modifications to the input string
    String modifiedString = input.toUpperCase() + " (Modified)";

    final dateString = input;

    final dateTime = DateTime.parse(dateString);
    final year = DateFormat('y').format(dateTime);

    //print('year: $year');

    return year;
  }
  //day

  String Return_day(String input) {
    // Perform some modifications to the input string
    final dateString = input;

    final dateTime = DateTime.parse(dateString);
    final day = DateFormat('d').format(dateTime);

    //print('day: $day');

    return day;
  }

  void initState() {
    // TODO: implement initState
    _controller.addListener(_scrollListener);

    useController.fetch_github(page_no);
    useController.fetch_github_label(page_no);
    _controller_search.text = "";
  }

  var refresh_status = 0;

  //not used
  void Timer_set_var() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        refresh_status = 1;
      });
    });
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd / MMM / yyyy');
    return formatter.format(date);
  }

  var useController = Get.put(userdata());
  Set<String> List_tag_set = {};
  List List_tag = [];
  Widget build(BuildContext context) {
    var height_safearea = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    var width_safearea2 = 392;
    var height_safearea2 = 750;
    return Scaffold(
        body: Obx(() => SafeArea(
              child: useController.isloading == 1
                  ? ListView.builder(
                      itemCount: useController.userList.length,
                      padding: EdgeInsets.all(6),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        Filter_function(index); // this will re arrange the userlist and make the filter !!!

                        /// the user list will automatically filtered if there is any tag added on the top
                        print(useController.userList.length);
                        String dateString = useController.userList[index].createdAt.toString();
                        DateTime dateTime = DateTime.parse(dateString);
                        print(dateTime);
                        return Container(
                            child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                index == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          print("Gestur detec");
                                          page_no_label++;
                                          useController.fetch_github_label(page_no_label);
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color.fromARGB(255, 230, 230, 238),
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 205, 189, 233),
                                            ),
                                          ),
                                          width: 130 / width_safearea2 * width_safearea,
                                          height: 30 / height_safearea2 * height_safearea,
                                          child: Center(
                                            child: Text(
                                              "Updates Tags+",  // here user can update the tag label pages and get a toast message and can find out all the tags available in a repo !!!

                                              /// refresh tags for refreshing all the pages of total label on a github repoo !!!! it will call 1 page at a time !!!
                                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                index == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          print("Gestur detec");
                                          page_no++;
                                          useController.fetch_github(page_no);
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color.fromARGB(255, 230, 230, 238),
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 205, 189, 233),
                                            ),
                                          ),
                                          width: 130 / width_safearea2 * width_safearea,
                                          height: 30 / height_safearea2 * height_safearea,
                                          child: Center(
                                            child: Text(
                                              "Refresh Pages+",

                                              /// refresh tags for refreshing all the pages of total label on a github repoo !!!! it will call 1 page at a time !!!
                                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            index == 0
                                ? Container(
                                    /// auto suggestion for finding the tags
                                    color: Colors.transparent,
                                    child: Autocomplete<String>(
                                      optionsBuilder: (TextEditingValue textEditingValue) {
                                        return useController.userListforGitLabel.where((String suggestion) => suggestion.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase(),
                                            ));
                                      },
                                      onSelected: (String selected) {
                                        print("striff " + selected);

                                        // setState(() {});
                                        useController.addToListTagAdded(selected);  /// on selecting any item that item will be added !!!!
                                      },
                                      fieldViewBuilder: (BuildContext context, _controller, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                                        return TextFormField(
                                          controller: _controller,
                                          focusNode: fieldFocusNode,
                                          onFieldSubmitted: (String value) {
                                            print(value);
                                          },
                                          onChanged: (val) {},
                                          decoration: InputDecoration(
                                              labelText: "Filter Tags".tr,
                                              labelStyle: TextStyle(
                                                color: Colors.deepPurpleAccent,

                                                fontSize: 0.017286396 * height_safearea,
                                                fontWeight: FontWeight.bold,
                                                //<-- SEE HERE
                                              ),
                                              prefixIcon: Icon(Icons.verified_user_outlined),
                                              border: OutlineInputBorder()),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(),
                            index != 0
                                ? SizedBox()
                                : Wrap(
                                    // here the added tag will showed!!!
                                    children: [
                                      for (var i = 0; i < useController.userListforGitLabelAdded.length; i++)
                                        Builder(builder: (BuildContext context) {
                                          return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color.fromARGB(237, 31, 146, 167),
                                                border: Border.all(
                                                  color: Color.fromARGB(216, 220, 248, 234),
                                                ),
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.all(3),
                                                      child: Wrap(
                                                        children: [
                                                          Text(
                                                            useController.userListforGitLabelAdded[i],
                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              print(i.toString());
                                                              page_no = 1;
                                                              useController.RemoveFromAddedList(i);
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              Icons.cancel_outlined,
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ));
                                        })
                                    ],
                                  ),
                            matched == 0
                                ? SizedBox()
                                : Container(
                                    // printing the tittle and body
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Container(
                                        width: 340 / width_safearea2 * width_safearea,
                                        height: 130 / height_safearea2 * height_safearea,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: const Color.fromARGB(255, 230, 230, 238),
                                          border: Border.all(
                                            color: const Color.fromARGB(255, 205, 189, 233),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    useController.userList[index].title.length > 20
                                                        ? useController.userList[index].title.substring(0, 20) 
                                                        : useController.userList[index].title ,
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                  //  List_tag // Post[index]['title'].length<10? Post[index]['title'] : Post[index]['title'].substring(0,20)+".."
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(left: 5, top: 3),
                                                    child: Container(
                                                      height: 30 / height_safearea2 * height_safearea,
                                                      child: Text(
                                                        useController.userList[index].body!.length > 20
                                                            ? useController.userList[index].body!.substring(0, 20)
                                                            : useController.userList[index].body!,
                                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                                                      ),
                                                    )),
                                                // printing lavbel
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.all(5),
                                                        child: Container(
                                                            width: 200 / width_safearea2 * width_safearea,
                                                            child: SingleChildScrollView(
                                                              scrollDirection: Axis.horizontal,
                                                              child: Wrap(
                                                                children: <Widget>[
                                                                  for (var i = 0; i < useController.userList[index].labels.length; i++)
                                                                    Card(
                                                                      color: Color.fromARGB(159, 231, 243, 243),
                                                                      child: Container(
                                                                        child: Center(
                                                                            child: Wrap(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.all(3),
                                                                              child: Text(
                                                                                // for label showing
                                                                                useController.userList[index].labels[i].name + " ",
                                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                                      ),
                                                                    )
                                                                ],
                                                              ),
                                                            )))
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 4),
                                                  child: Text(
                                                    Return_day(dateTime.toString()) + " " + Return_month(dateTime.toString()) + " " + Return_Year(dateTime.toString()),
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 4),
                                                  child: Text(
                                                    useController.userList[index].user.login.length > 6
                                                        ? useController.userList[index].user.login.substring(0, 6)
                                                        : useController.userList[index].user.login,
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ) // dlt
                            ,

                            // if it is scrolling the data will load !!!!
                            refresh_status == 0 && _controller.position.pixels == _controller.position.maxScrollExtent && index == useController.userList.length - 1
                                ? Container(
                                    height: 100,
                                    width: 100 / 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ))
                                : refresh_status == 1 && index == useController.userList.length - 1
                                    ? GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                            color: Colors.green,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text("Not More data to show"),
                                            )),
                                      )
                                    : SizedBox()
                          ],
                        ));
                      })
                  : SizedBox(),
            )));
  }
}
