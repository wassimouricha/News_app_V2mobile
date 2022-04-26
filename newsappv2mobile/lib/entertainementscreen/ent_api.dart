// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsappv2mobile/entertainementscreen/modelentertainement.dart';

Future<List<EntApiModel>> getNews() async {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=fr&category=entertainment&apiKey=56673b513f424d3e9d4ce0afc8293687");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<EntApiModel> entList = _articalsList
        .map((jsonData) => EntApiModel.fromJson(jsonData))
        .toList();

    print(_articalsList);

    return entList;
  } else {
    print("erreur");
    return [];
  }
}
