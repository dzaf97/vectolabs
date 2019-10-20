import 'callApi.dart';
import 'searchItemWindow.dart';
import 'getItemWindow.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/show': (context) => ShowItem(post: fetchPost()),
        '/search': (context) =>
            SearchItem(post: searchPost(searchController.text))
      },
    ),
  );
}

TextEditingController searchController = new TextEditingController();

//UI for HomePage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Stack(
          children: <Widget>[
            Text(
              'Family Mart',
              style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 3,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.blue),
            ),
            Text(
              'Family Mart',
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 3,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(3.0),
            child: Image.asset('assets/groceries.jpg', height: 190),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Text(
              'Welcome to Family Mart!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Product ID'),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  'Get all items',
                  style: TextStyle(fontSize: 15),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green[200],
                onPressed: () {
                  Navigator.pushNamed(context, '/show');
                },
              ),
              RaisedButton(
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 15),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green[200],
                onPressed: () {
                  if (searchController.text != '') {
                    return Navigator.pushNamed(context, '/search');
                  } else {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Invalid Product ID!'),
                          content: Text('Please enter a valid Product ID'),
                          backgroundColor: Colors.green[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          titleTextStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'Okay',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}