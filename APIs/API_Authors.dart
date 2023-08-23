import 'dart:convert';
import 'package:flutter/material.dart';
import '../modelClass/ebook.dart';
import 'package:http/http.dart' as http;
import '../modelClass/ebook.dart';
import '../modelClass/popular author.dart';

class Author_Provider extends ChangeNotifier {
  List<author> authorsList = [];

  void fetchData_authors() async {
    var uri = Uri.https('hapi-books.p.rapidapi.com', '/top_authors');
    final resp = await http.get(uri, headers: {
      'X-RapidAPI-Key': '483015f44amshb571554f1ac90dap195a4djsn5e94a6c8ff5e',
      'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
    });

    if (resp.statusCode == 200) {
      var body = jsonDecode(resp.body);
      List<dynamic>? list = body;
      for (int i = 0; i < list!.length; i++) {
        authorsList.add(author.fromJson(list[i]!));
      }
    } else {
      throw Exception('Failed to load Data');
    }
    notifyListeners();
  }
}
