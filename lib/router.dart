import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honguyen/main.dart';
import 'package:honguyen/classdefine.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
class InfoRoute extends StatelessWidget {
  Future<InfoApp> futureInfo;
  var futureInfos = fetchInfo();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle + " - Thông Tin"),
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        height: 1000.0,
        width: 1000.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: FutureBuilder<InfoApp>(
              future: futureInfos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Html(
                      padding: EdgeInsets.all(5),
                      data: snapshot.data.title,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              }),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle + " - Tin Tức"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
