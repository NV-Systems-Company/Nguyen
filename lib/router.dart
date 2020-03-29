import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honguyen/main.dart';
import 'package:honguyen/classdefine.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'dart:developer';

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
  FutureBuilder<NewsList> futureListNew;
  var futureListNews = fetchListNews();
  List<dynamic> datan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle + " - Tin Tức"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<NewsList>(
              future: futureListNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var datanew = jsonDecode(snapshot.data.data);
                  datan = datanew;

                  return ListView.builder(
                      itemCount: datanew == null ? 0 : datanew.length,
                      itemBuilder: (BuildContext context, int index) {
                        var id_news = datanew[index]['id'].toString();
                        var htmldata = '<div><div>' +
                            id_news +
                            '</div><div><h1>' +
                            datanew[index]['title'] +
                            '</h1><p>' +
                            datanew[index]['hometext'] +
                            '</p></div>';
                        log(datanew[index]['homeimgfile']);
                        return Table(
                          columnWidths: {0:FractionColumnWidth(.3)},
                          children: [
                            TableRow(
                              children: [
                                Html(
                                  data:'<div style="float:left;width="50px">' +
                                      '<img width="50px" height="50px" src="' +
                                      datanew[index]['homeimgfile'] +
                                      '"</img>' +
                                      '</div>',
                                ),
                                Html(
                                  data: '<div >' +
                                      '<h3>' +
                                      datanew[index]['title'] +
                                      '</h3>' +
                                      '<p>' +
                                      datanew[index]['hometext'] +
                                      '</p>' +
                                      '</div>',
                                ),
                              ]
                            )
                          ],
                        );
                      });
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
