import 'package:flutter/material.dart';

// state Management of the App
class MainScreenNotifer extends ChangeNotifier {
   int _pageIndex = 0;

  // get current page index
   int get pageIndex => _pageIndex;


   // set current  page index 
   set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
   }
}