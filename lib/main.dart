import 'package:challenge_app/repository/conta_repository.dart';
import 'package:challenge_app/repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ContaRepository()),
      ChangeNotifierProvider(create: (context) => FavoritesRepository()),
    ],
    child: MyApp(),
  ));
}
