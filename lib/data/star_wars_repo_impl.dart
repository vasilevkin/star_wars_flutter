import 'package:star_wars_flutter/data/api_service.dart';
import 'package:star_wars_flutter/data/star_wars_repo.dart';
import 'package:star_wars_flutter/models/people.dart';

class StarWarsRepoImpl implements StarWarsRepository {
  final ApiService api;

  StarWarsRepoImpl({required this.api});

  @override
  Future<List<Character>?> getAllCharacters() async {
    final chars = api.getAllPeople();

    // print('chars= $chars');

    return chars;
  }

  @override
  Future<List<Character>?> searchCharacterByName(String name) {
    final chars = api.getCharacter(name);

    // print('chars= $chars');

    return chars;
  }
}
