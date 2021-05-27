import 'package:flutter/material.dart';
import 'package:star_wars_flutter/data/api_service_impl.dart';
import 'package:star_wars_flutter/models/film.dart';
import 'package:star_wars_flutter/models/people.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  DetailsScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details: ${character.name}'),
      ),
      body: _buildBody(character),
    );
  }

  Widget _buildBody(Character character) {
    return ListView(
      children: [
        CharacterDetailsListItem(
            title: 'name', items: [character.name ?? 'empty']),
        // Card(child: Text('name: ${character.name}'),),
        Card(
          child: Text('height: ${character.height}'),
        ),
        Card(
          child: Text('mass: ${character.mass}'),
        ),
        Card(
          child: Text('hairColor: ${character.hairColor}'),
        ),
        Card(
          child: Text('skinColor: ${character.skinColor}'),
        ),
        Card(
          child: Text('eyeColor: ${character.eyeColor}'),
        ),
        Card(
          child: Text('birthYear: ${character.birthYear}'),
        ),
        Card(
          child: Text('gender: ${character.gender}'),
        ),
        Card(
          child: Text('homeworld: ${character.homeworld}'),
        ),

        CharacterDetailsListItem(title: 'films', items: character.films ?? []),

        // Card(child: Text('films: ${character.films}'),),
        Card(
          child: Text('species: ${character.species}'),
        ),
        Card(
          child: Text('vehicles: ${character.vehicles}'),
        ),
        Card(
          child: Text('starships: ${character.starships}'),
        ),
        Card(
          child: Text('created: ${character.created}'),
        ),
        Card(
          child: Text('edited: ${character.edited}'),
        ),
        Card(
          child: Text('url: ${character.url}'),
        ),
      ],
    );
  }
}

class CharacterDetailsListItem extends StatelessWidget {
  final String title;
  final List<String> items;

  final api = StarWarsApiService();

  CharacterDetailsListItem({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.length == 1) {
      return ListTile(title: Text('$title: ${items.first}'));
    } else {
      return ExpansionTile(
        title: Text(title),
        subtitle: Text(items.length.toString()),
        children: [
          ...items.map(
            (e) => FutureBuilder(
                future: api.getFilm(e),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Film film = snapshot.data as Film;

                    return ListTile(
                      title: Text(film.title ?? 'empty'),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return CircularProgressIndicator();
                }),
          ),
        ],
      );
    }
  }
}
