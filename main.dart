import 'package:ebook/APIs/API_Authors.dart';
import 'package:ebook/introPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'APIs/API.dart';
import 'introPage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Book_Provider>(create: (context) {
      return Book_Provider();
    }),
    ChangeNotifierProvider<Author_Provider>(create: (context) {
      return Author_Provider();
    }),
  ], child: MaterialApp(home: introPage())));
}
