import 'package:star_wars_flutter/models/film.dart';
import 'package:star_wars_flutter/models/people.dart';

abstract class ApiService {
  Future<List<Character>> getAllPeople();

  Future<List<Character>?> getCharacter(String name);

  Future<Film> getFilm(String url);
}
