import 'package:ebook/APIs/API.dart';
import 'package:ebook/popularAuthors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'APIs/API_Authors.dart';
import 'FavouritePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<Book_Provider>(context, listen: true);
    final provider = Provider.of<Author_Provider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.brown.shade50,
        body: _provider.BooksList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
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
                                        builder: (context) =>
                                            popularAuthors()));
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
                          itemCount: _provider.BooksList.length,
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
                                          "${_provider.BooksList[index].cover}",
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
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.brown.withOpacity(0.2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          child: Text(
                                              "${_provider.BooksList[index].name}",
                                              style: TextStyle(
                                                  color: Colors.brown.shade900,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          onPressed: () async {
                                            var url =
                                                '${_provider.BooksList[index].url}';

                                            await launch(url);
                                          },
                                        ),
                                        RatingBarIndicator(
                                            rating: double.parse(
                                                "${_provider.BooksList[index].rating}"),
                                            itemCount: 5,
                                            itemSize: 30.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 10, top: 10),
                                          child: Text(
                                              "${_provider.BooksList[index].rating}",
                                              style: TextStyle(
                                                  color: Colors.brown.shade600,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (_provider.BooksList[index]
                                                    .IsFavourite ==
                                                false) {
                                              _provider.add_Favourite(index);
                                            } else {
                                              _provider.removeFavourites(index);
                                            }
                                          },
                                          icon: _provider
                                                  .BooksList[index]!.IsFavourite!
                                              ? Icon(
                                                  Icons.favorite,
                                                  size: 25,
                                                  color: Colors.redAccent,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  size: 25,
                                                ),
                                        ),
                                      ],
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
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded, color: Colors.white),
              label: 'Search',
            ),
          ],
          onTap: (int items) {
            if (items == 2) {
            } else if (items == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavouritePage()),
              );
            } else if (items == 0) {
              //Make Refresh to Home Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
        ));
  }

  @override
  void initState() {
    final _provider = Provider.of<Book_Provider>(context, listen: false);
    final provider = Provider.of<Author_Provider>(context, listen: false);
    // TODO: implement initState
    //super.initState();
    _provider.fetchData_books();
    provider.fetchData_authors();
    print("object");
  }
}
