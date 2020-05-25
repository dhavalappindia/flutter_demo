import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdemo/main_ui/second_ui.dart';
import 'package:flutterdemo/model/kitten_model.dart';
import 'package:flutterdemo/util/utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}



class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

/*--------------------set data in list----------------------------------------*/
List data;
List<Kitten> _kittens = new List<Kitten>();

class HomePageState extends State<HomePage> {
  Future<Kitten> getData() async {
    var response = await http.get(Uri.encodeFull(base_url), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      for (int i = 0; i < data.length; i++)
      {
        print(data[i]["id"]);

        _kittens.add(
          Kitten(
              userId: data[i]["userId"],
              id: data[i]["id"],
              title: data[i]["title"],
              body: data[i]["body"]),
        );

      }
//    return Kitten.fromJson(json.decode(response.body));
    } else {
//      throw Exception('Failed to load album');
    }

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Availabel Kittens'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _kittens.length,
        itemExtent: 160.0,
        itemBuilder: _listItemBuilder,
      ),
    );
  }
}

/*--------------------Create listView---------------------------------------*/
Widget _listItemBuilder(BuildContext context, int index) {
  return Card(
    child: new GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => _dialogBuilder(context, _kittens[index])),
      child: new Container(
        padding: EdgeInsets.zero,
//        height: 120.0,
//        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: ListTile(
          leading: FadeInImage.assetNetwork(
            placeholder: 'assets/logos/loadinggiphy.gif',
            image:'https://picsum.photos/250?image=9',
//        image: kitten.imageUrl,
// width: 50,
//            height: 50,

            fit: BoxFit.fitWidth,
          ),
//          title: Text(_kittens[index].title,
//            textDirection: TextDirection.ltr,
//            maxLines: 1,
//            style: TextStyle(
//                fontSize: 20.0,
//            ),
//
//          ),
        ),
    ),
    ),
  );
}

/*--------------------Create Dialog-----------------------------------------*/
Widget _dialogBuilder(BuildContext context, Kitten kitten) {
  ThemeData localTheme = Theme.of(context);
  return SimpleDialog(
    //children: [Container(width: 80.0,height: 80.0,)],);
    contentPadding: EdgeInsets.zero,
    children: [
      FadeInImage.assetNetwork(
        placeholder: 'assets/logos/loadinggiphy.gif',
        image: 'https://picsum.photos/250?image=9',
//        image: kitten.imageUrl,
        fit: BoxFit.fill,
      ),

      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              kitten.title,
              style: localTheme.textTheme.display1,
            ),
            Text(
              '${kitten.userId}months old',
              style: localTheme.textTheme.subhead.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              kitten.body,
              style: localTheme.textTheme.body1,
            ),
            SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      //close dialog
                      Navigator.of(context).pop();
                      //open new screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
