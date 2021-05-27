import 'package:flutter/material.dart';
import 'package:star_wars_flutter/app/app_routes.dart';
import 'package:star_wars_flutter/ui/screens/home_screen.dart';

class StarWarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  Widget _buildApp() {
    return MaterialApp(
      title: 'Star Wars Flutter app',
      routes: {
        StarWarsAppRoutes.home: (_) => HomeScreen(),
        // StarWarsAppRoutes.details: (_) => DetailsScreen(character: ,),
      },
    );
  }
}
