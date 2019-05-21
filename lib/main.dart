// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'dart:async';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp(profile: fetchProfile()));

class MyApp extends StatelessWidget {
  final Future<Profile> profile;

  MyApp({this.profile});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        home: FutureBuilder<Profile>(
              future: profile,
              builder: (context, snapshot) {
                Widget body;
                if (snapshot.hasData) {
                  body = new BodyHome(profile: snapshot.data);
                } else if (snapshot.hasError) {
                  body = Text("${snapshot.error}");
                } else {
                  // By default, show a loading spinner
                  body = new BodyLoading();
                }

                return new Material(
                              type: MaterialType.transparency,
                              child: body)
                            ;
              },
        ),
    );
  }
}

class BodyLoading extends StatelessWidget {

    @override
    Widget build (BuildContext ctxt) {
      return Container(
                  width: 100.0,
                  child: Center(
                    child: Align( alignment: Alignment.center, 
                                  child: Container (
                                    child: new CircularProgressIndicator()
                                ) 
                  )
                )
      );
    }

}

class BodyHome extends StatelessWidget {

    final Profile profile;

    BodyHome({this.profile});

    @override
    Widget build (BuildContext ctxt) {
      return Container (
          decoration: new BoxDecoration(color: Colors.white),
          width: 100.0,
          child: Center(
            child: Align( alignment: Alignment.center, 
                          child: Container (
                            child: new ListDisplay(profile: profile)
                        ) 
          )
      )
      );
    }

}

class ListDisplay extends StatelessWidget {

    final Profile profile;

    ListDisplay({this.profile});

    @override
    Widget build (BuildContext ctxt) {
      return new ListView.builder
      (
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: this.profile.posts.length,
        itemBuilder: (BuildContext ctxt, int index) => buildItem(ctxt, index)
      );
    }

    Widget buildItem(BuildContext ctxt, int index) {
      return new Center(child: Text(
          profile.posts[index].title,
          style: TextStyle( fontWeight: FontWeight.bold, 
                            color: Colors.black, 
                            fontFamily: "SourceSans",
                            fontSize: 30),
        )
      );
    }
}

Future<Profile> fetchProfile() async {
  final response =
      await http.get('https://moisespersonalpage.firebaseio.com/profile/0.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Profile.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class PostFeed {
  final int id;
  final String title;
  final String description;

  PostFeed({this.id, this.title, this.description});

  factory PostFeed.fromJson(Map<String, dynamic> jsonfeed) {
    return PostFeed(
      id: jsonfeed['id'],
      title: jsonfeed['title'],
      description: jsonfeed['description']
    );
  }
}

class Profile {
  final String name;
  final String surname;
  final List<PostFeed> posts;

  Profile({this.name, this.surname, this.posts});

  factory Profile.fromJson(Map<String, dynamic> json) {
    var list = json['posts'] as List;
    List<PostFeed> itemsList = list.map((i) => PostFeed.fromJson(i)).toList();

    return Profile(
      name: json['name'],
      surname: json['surname'],
      posts: itemsList
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/