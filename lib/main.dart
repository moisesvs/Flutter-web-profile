// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'dart:async';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
import 'data/Profile.dart';
import 'package:http/http.dart' as http;
import 'widgets/Body.dart';

void main() => runApp(MyApp(profile: fetchProfile()));

class MyApp extends StatelessWidget {
  final Future<Profile> profile;

  MyApp({this.profile});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        theme: ThemeData(
                // Define the default Brightness and Colors
                brightness: Brightness.dark,
                primaryColor: Colors.grey,
                accentColor: Colors.grey,
                
                // Define the default Font Family
                fontFamily: 'SourceSans',

                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
                textTheme: TextTheme(
                  headline: TextStyle(fontSize: 72.0),
                  title: TextStyle(fontSize: 70.0),
                  body1: TextStyle(
                              fontSize: 14.0),
                ),
              ),
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

                return Scaffold (
                      backgroundColor: Colors.white,
                      body: body
                );
              },
        ),
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