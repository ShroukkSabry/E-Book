import 'package:ebook/APIs/API.dart';
import 'package:ebook/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'APIs/API_Authors.dart';
import 'FavouritePage.dart';

class popularAuthors extends StatefulWidget {
  const popularAuthors({Key? key}) : super(key: key);

  @override
  State<popularAuthors> createState() => _popularAuthorsState();
}

class _popularAuthorsState extends State<popularAuthors> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Author_Provider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.brown.shade50,
        body: Container(
            height: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          });
                        },
                        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            elevation: 12.0,
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Text('Books'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => popularAuthors()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            elevation: 12.0,
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Text('Popular Authors '),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 30,
                          thickness: 2,
                          color: Colors.brown.shade800.withOpacity(.2),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: provider.authorsList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 26,
                                ),
                                SizedBox(
                                    height: 200,
                                    child: Image.network(
                                      "${provider.authorsList[index].image}",
                                      fit: BoxFit.fill,
                                    )),
                                SizedBox(
                                  height: 30,
                                  width: 98.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                width: 150,
                                height: 250,
                                padding: EdgeInsets.only(top: 10, left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.brown.withOpacity(0.2),
                                ),
                                child: 
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        child: Text(
                                            "${provider.authorsList[index].name}",
                                            style: TextStyle(
                                                color: Colors.brown.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        onPressed: () {},
                                      ),
                                      Text("-Popular Book:",
                                          style: TextStyle(
                                              color: Colors.brown.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      TextButton(
                                        child: Text(
                                            "${provider.authorsList[index].popular_book_title}",
                                            style: TextStyle(
                                                color: Colors.brown.shade400,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        onPressed: () async {
                                          var url =
                                              '${provider.authorsList[index].popular_book_url}';

                                          await launch(url);
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("-Number of published Books:",
                                          style: TextStyle(
                                              color: Colors.brown.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      Text(
                                          "${provider.authorsList[index].number_published_books}",
                                          style: TextStyle(
                                              color: Colors.brown.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 5,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.brown.shade800.withOpacity(0.8),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.white),
              label: 'Favorites',
            ),
          ],
          onTap: (int items) {
            if (items == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavouritePage()),
              );
            } else if (items == 0) {
              //Make Refresh to Home Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const popularAuthors()),
              );
            }
          },
        ));
  }

  @override
  void initState() {
    final provider = Provider.of<Author_Provider>(context, listen: false);
    // TODO: implement initState
    //super.initState();
    provider.fetchData_authors();
  }
}
