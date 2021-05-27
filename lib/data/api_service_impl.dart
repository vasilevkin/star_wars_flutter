import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_flutter/data/api_service.dart';
import 'package:star_wars_flutter/models/film.dart';
import 'package:star_wars_flutter/models/people.dart';

// const host = 'swapi.dev';
// const api = '${host}api/';

class StarWarsApiService implements ApiService {
  @override
  Future<List<Character>?> getCharacter(String name) async {
    var queryParameters = {
      'search': '$name',
    };

    final Uri url = Uri.parse('https://swapi.dev/api/people/?search=$name');
    // Uri.https('swapi.dev', 'api/people/', queryParameters);
    // final Uri url = Uri.https('swapi.dev', 'api/people/\\?search=$name');
    final response = await http.get(url);

    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final peopleData = data['results'] as List?;
    final peopleList = peopleData?.map((e) => Character.fromJson(e)).toList();

    print('peopleList= $peopleList');

    return peopleList;
  }

  @override
  Future<List<Character>> getAllPeople() async {
    final Uri url = Uri.https('swapi.dev', 'api/people/');
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final peopleData = data['results'] as List;
    final peopleList = peopleData.map((e) => Character.fromJson(e)).toList();

    print('peopleList= $peopleList');

    return peopleList;
  }

  @override
  Future<Film> getFilm(String url) async {
    final Uri requestUrl = Uri.parse(url);
    // Uri.https('swapi.dev', 'api/people/', queryParameters);
    // final Uri url = Uri.https('swapi.dev', 'api/people/\\?search=$name');
    final response = await http.get(requestUrl);

    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);

    return Film.fromJson(data);
  }
}
