// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class details extends StatelessWidget {
  details({required this.recipes, required this.recipesindex});
  String recipes = "";
  String recipesindex = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1620810005858-cff624bd75d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80'),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      recipes,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    feyching(
                      index: recipesindex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class feyching extends StatefulWidget {
  feyching({required this.index});
  String index = "";

  @override
  State<feyching> createState() => _feychingState();
}

class _feychingState extends State<feyching> {
  List items = [];

  @override
  void initState() {
    super.initState();
    Fetchingredient(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.brightness_1,
            color: Colors.white,
            size: 7,
          ),
          minLeadingWidth: 10,
          title: Text(
            "${items[index]}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  void Fetchingredient(String index) async {
    const String Api_Key = "";

    String urlString =
        "https://yummly2.p.rapidapi.com/feeds/list?rapidapi-key=$Api_Key";

    var url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    print(response.body);

    var responseBody = response.body;

    var parsedResponse = json.decode(responseBody);
    List _items = [];
    int count = int.parse(index);
    if (parsedResponse['feed'][count]['content']['ingredientLines'] == null) {
      setState(() {
        items = ["Recipe not found."];
      });
    } else {
      for (var i in parsedResponse['feed'][count]['content']
          ['ingredientLines']) {
        _items.add(i['wholeLine']);
      }
      // items =
      //     parsedResponse['feed'][0]['content']['ingredientLines'][0]['wholeLine'];
      setState(() {
        items = _items;
      });
    }
  }
}
