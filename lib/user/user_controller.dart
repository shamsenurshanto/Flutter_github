import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_app/models/github_issues.dart';
import 'package:my_app/models/labelGithub.dart';
import 'package:my_app/service/api_service.dart';

class userdata extends GetxController {
  var isloading = 0.obs;
  var userList = <DataListFromGitIssues>[].obs;
  var userList_backup = <DataListFromGitIssues>[].obs;

  /// all the label of git repo
  var userListforGitLabel = <String>[].obs;

  var listLastItemLoadingChecker = 0.obs;
  var listLastItemLoadingCheckerMove = 0.obs;

  // label page calling
  var labelPageCalling = 0.obs;

  //tag added
  var userListforGitLabelAdded = <String>[].obs;
  var List_tag_set = <String>[].obs;

// adding the issues lis

  Future<void> fetch_github(var page) async {
    if (listLastItemLoadingChecker.value == 1) listLastItemLoadingChecker(0);
    listLastItemLoadingCheckerMove(0);
    print("ddd");
    if (isloading.value == 0) {
      isloading.value = 1;
    }
    List<DataListFromGitIssues> userdata = await api_service().fetchDataGithubIssues(page);

    print("page and backedup " + page.toString() + " " + userList_backup.toString());
    userList += userdata;
    userList_backup += userList;
    var matched, label;
    if (userdata.length == 0)
      Fluttertoast.showToast(
        msg: "Failed to load more data !!!!!",
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP,
      );
    // filter_change();
    // userList.addAll(userdata);
    isloading(1);
    listLastItemLoadingChecker(1);

    Fluttertoast.showToast(
      msg: "Page has been refreshed !!",
      toastLength: Toast.LENGTH_SHORT, // Toast duration (short or long)
      gravity: ToastGravity.BOTTOM, // Toast position (top, center, bottom)

      fontSize: 16.0, // Text size
    );

    Timer(Duration(seconds: 2), () {
      listLastItemLoadingCheckerMove(1);
    });
  }

  ///filter list userList userListforGitLabelAdded
  Future<void> filter_change() async {
    for (int index = 0; index < userList.length; index++) {
      var matched = 0;
      String label;
      if (userListforGitLabelAdded.length > 0) {
        for (int j = 0; j < userListforGitLabelAdded.length; j++) {
          matched = 0;
          String filter = userListforGitLabelAdded[j];
          print("filrer " + filter);

          for (int i = 0; i < userList[index].labels.length; i++) {
            label = userList[index].labels[i].name.toString();
            print("index - label " + index.toString() + " " + label.toString());
            if (label.toLowerCase().contains(filter.toLowerCase())) {
              matched = 1;
              break;
            }
          }
          if (matched == 0) break;
        }
        if (matched == 0) // does not have any of the filters
        {
          userList.removeAt(index);
        } else {}
      }
    }
  }

  void listLastItemLoadingCheckerMove_fun() {
    if (listLastItemLoadingCheckerMove.value == 0)
      listLastItemLoadingCheckerMove(1);
    else {
      listLastItemLoadingCheckerMove(0);
    }
  }

  //label; fetching list

  Future<void> fetch_github_label(var page) async {
    // var page =1;

    print("labelk ddd ");
    if (labelPageCalling.value == 0) {
      List<String> userdata = await api_service().fetchDataLabelGithub(page);
      if (userdata.length == 0) {
        print("finished  " + page.toString());
        labelPageCalling.value = 1;
      }
      userListforGitLabel += userdata;
    }
    Fluttertoast.showToast(
      msg: "Tag list updated !!! \n Total available tags is " + userListforGitLabel.length.toString(),
      toastLength: Toast.LENGTH_SHORT, // Toast duration (short or long)
      gravity: ToastGravity.BOTTOM, // Toast position (top, center, bottom)

      fontSize: 16.0, // Text size
    );
    // userList.addAll(userdata);
  }

  Future<void> addToListTagAdded(var addedItems) async {
    // var page =1;

    print("labelk ddd");

    userListforGitLabelAdded.add(addedItems);
    filter_change();

    // userList.addAll(userdata);
  }

  Future<void> RemoveFromAddedList(int index) async {
    userListforGitLabelAdded.removeAt(index);
    if (userListforGitLabelAdded.length == 0) fetch_github(1);
  }
}
