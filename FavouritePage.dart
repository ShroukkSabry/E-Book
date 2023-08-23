import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'APIs/API.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<Book_Provider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text("Favourites"), backgroundColor: Colors.brown.shade700),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _provider.Addfavourites.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        var url = '${_provider.BooksList[index].url}';
                        await launch(url);
                      },
                      child: Text(
                        "-"
                        "${_provider.Addfavourites[index].name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.brown),
                      ),
                    ),
                    Image.network(
                      "${_provider.Addfavourites[index].cover}",
                      fit: BoxFit.fill,
                    )
                  ],
                );
              },
            )));
  }
}
