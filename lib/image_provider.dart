import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProvideImage with ChangeNotifier {
  Album _photoList;

  Album get getAlbum {
    return _photoList;
  }

  Future<void> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://picsum.photos/v2/list?page=3&limit=100'));
    print(response.body);
    if (response.statusCode == 200) {
      final responseBody = response.body;

      final decoded = jsonDecode(responseBody);
      _photoList = Album.fromJson(decoded);
      notifyListeners();
      return _photoList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class Album {
  List<Photo> photos;

  Album({@required this.photos});

  factory Album.fromJson(List<dynamic> parsedJson) {
    List<Photo> photos = parsedJson.map((i) => Photo.fromJson(i)).toList();

    return Album(photos: photos);
  }
}

class Photo {
  final String id;
  final String author;
  final String url;

  Photo({
    @required this.id,
    @required this.author,
    @required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json["id"],
      author: json["author"],
      url: json["download_url"],
    );
  }
}
