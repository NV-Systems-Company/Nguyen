import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:honguyen/main.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';



class InfoApp {
  final String status;
  final String code;
  final String title;

  InfoApp({this.status,  this.code, this.title});

  factory InfoApp.fromJson(Map<String, dynamic> json) {
    return InfoApp(
      status: json['status'],
      code: json['code'],
      title: json['message'],
    );
  }
}
class NewsList {
  final String data;

  NewsList({this.data});

  factory NewsList.fromJson(json) {
    return NewsList(
      data: json,
    );
  }
}

Future<InfoApp> fetchInfo() async {
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"action": "InfoFirstRow", "module": "about", "language": "vi"}';
  final response = await http.post(API,headers: headers,body: json);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return InfoApp.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<NewsList> fetchListNews() async {
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"action": "ListNewsItems", "module": "news", "language": "vi"}';
  final response = await http.post(API,headers: headers,body: json);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var request_data = jsonDecode(response.body);

    return NewsList.fromJson(request_data['message']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}




