import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_flutter/data/api_service_impl.dart';
import 'package:star_wars_flutter/data/star_wars_repo_impl.dart';
import 'package:star_wars_flutter/models/people.dart';
import 'package:star_wars_flutter/ui/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final
      // StarWarsRepository
      repo = StarWarsRepoImpl(api: StarWarsApiService());

  final api = StarWarsApiService();

  List<Character> _characters = [];
  String? _characterName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Flutter app'),
      ),
      body: _makeBody(),
    );
  }

  _makeBody() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search characters',
              contentPadding: EdgeInsets.all(8),
            ),
            onChanged: (value) {
              print('onChanged: (value)= $value');
              onChangedText(value);
            },
          ),
          Expanded(
            child: _characters.length == 0
                ? Padding(
                    padding: EdgeInsets.all(24),
                    child: _characterName == null
                        ? Text('Enter character name ...')
                        : Text('<<< Character not found >>>'),
                  )
                : ListView.builder(
                    itemCount: _characters.length,
                    itemBuilder: (context, index) {
                      final character = _characters[index];

                      return GestureDetector(
                          onTap: () => _onItemTap(character),
                          child: SizedBox(
                              height: 70,
                              child: Card(
                                child: Text(character.name ?? 'no name'),
                              )));
                    }),

            // FutureBuilder(
            //   future: characters,
            //   builder: (context, snapshot) {
            //
            //
            //     final sn = snapshot;
            //
            //     if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //
            //     }
            //
            //
            //     if (snapshot.hasData) {
            //       final data = snapshot.data as List<Character>;
            //
            //       return ListView.builder(
            //         itemCount: data.length,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             child: Text(
            //                 data[index].name ??
            //                     'no name'),);
            //         },
            //
            //       );
            //
            //   }
            //
            //     return CircularProgressIndicator();
            //
            //   },
            //
            //
            // ),
            // Container(),
          ),
        ],
      ),
    );
    // FloatingSearchBar(body: Container(),builder: (){},);
    //   ListView(
    //   children: [
    //     Row(children: [Text('test')],),
    //   ],
    // );
  }

  void onChangedText(String text) async {
    if (text == '' || text.length == 0) {
      setState(() {
        _characters.clear();
        _characterName = null;
      });
    } else {
      await api.getCharacter(text).then((value) {
        // await repo.searchCharacterByName(text) .then((value) {
        setState(() {
          if (value != null) {
            _characters = value;
            _characterName = value.first.name;
          }
          // else {
          //   _characters.clear();
          //   _characterName = '';
          // }
        });
      });
    }
  }

  void _onItemTap(Character character) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(character: character)));
  }
}
