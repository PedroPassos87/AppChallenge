import 'package:challenge_app/repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/spender_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(0.7),
      appBar: AppBar(
        title: Text(
          'Apps to watch',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        child: Consumer<FavoritesRepository>(
          builder: (context, favorites, child) {
            return favorites.list.isEmpty
                ? Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 40,
                        ),
                        title: Text(
                          'Ainda nao há apps favoritos',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.deepPurple[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  )
                : ListView.builder(
                    itemCount: favorites.list.length,
                    itemBuilder: (_, index) {
                      return SpenderCard(spender: favorites.list[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
