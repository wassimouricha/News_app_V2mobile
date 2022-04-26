// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsappv2mobile/businesscreen/modelbusiness.dart';

Future<List<BizApiModel>> getNews() async {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=fr&category=business&apiKey=56673b513f424d3e9d4ce0afc8293687");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<BizApiModel> bizList = _articalsList
        .map((jsonData) => BizApiModel.fromJson(jsonData))
        .toList();

    print(_articalsList);

    return bizList;
  } else {
    
    print("erreur");
    return [];
  }
}
