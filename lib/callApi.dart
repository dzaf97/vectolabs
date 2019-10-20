import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get('http://staging.vectolabs.com/getdata',
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final List<dynamic> data;

  Post({this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'];
    return Post(
      data: dataFromJson,
    );
  }
}

Future<Search> searchPost(searchData) async {
  final response = await http.get(
      'http://staging.vectolabs.com/search?search=' + searchData,
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Search.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Search {
  final List<dynamic> data;
  final bool error;

  Search({this.data, this.error});

  factory Search.fromJson(Map<String, dynamic> json) {
    var searchFromJson = json['data'];
    
    return Search(data: searchFromJson, error: json['error']);
  }
}