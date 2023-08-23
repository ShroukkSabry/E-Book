import 'package:flutter/material.dart';

import 'HomePage.dart';
//import 'package:provider/provider.dart';

class introPage extends StatefulWidget {
  const introPage({Key? key}) : super(key: key);
  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  @override
  Widget build(BuildContext context) {
    //  final _provider=Provider.of<Movies_Provider>(context);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/backgroundd.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 700,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.withOpacity(0.3)),
              onPressed: () {
                // Go to Next Page (Home Page)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text('Get Started'),
            ),
          ],
        ));
  }
}
