import 'package:star_wars_flutter/models/people.dart';

abstract class StarWarsRepository {
  Future<List<Character>?> getAllCharacters();

  Future<List<Character>?> searchCharacterByName(String name);
}
