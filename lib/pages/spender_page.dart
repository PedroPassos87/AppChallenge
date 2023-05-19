import 'package:challenge_app/models/spender.dart';
import 'package:challenge_app/pages/spender_details_page.dart';
import 'package:challenge_app/repository/favorites_repository.dart';
import 'package:challenge_app/repository/spender_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpenderPage extends StatefulWidget {
  const SpenderPage({Key? key}) : super(key: key);

  @override
  State<SpenderPage> createState() => _SpenderPageState();
}

class _SpenderPageState extends State<SpenderPage> {
  List<Spender> selecionadas = [];
  final tabela = SpenderRepository.tabela;
  late FavoritesRepository favorites;

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Seus Gastos'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => SpenderRepository().sort(),
              icon: const Icon(Icons.swap_vert_circle)),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined),
          onPressed: () {
            clearSelecionadas();
          },
        ),
        title: Text('${selecionadas.length} selected'),
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
      );
    }
  }

  showDetails(Spender spender) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpenderDetailsPage(
          spender: spender,
        ),
      ),
    );
  }

  clearSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favorites = Provider.of<FavoritesRepository>(context);

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int spender) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: ListTile(
                tileColor: Colors.transparent, // Set the tileColor to transparent
                contentPadding: EdgeInsets.zero, // Remove the default padding
                visualDensity: VisualDensity(horizontal: 0, vertical: -3), // Adjust the vertical density

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                leading: (selecionadas.contains(tabela[spender]))
                    ? CircleAvatar(
                        child: Icon(Icons.check),
                      )
                    : SizedBox(
                        child: Image.asset(tabela[spender].icon),
                        width: 45,
                      ),
                title: Row(
                  children: [
                    Text(
                      tabela[spender].name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (favorites.list.contains(tabela[spender]))
                      Icon(
                        Icons.star,
                        color: Colors.indigo,
                        size: 15,
                      ),

                    if(tabela[spender].limit != null)
                      if(tabela[spender].spent >= tabela[spender].limit!*0.5)
                        Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                          size: 15,
                        ),

                  ],
                ),
                trailing: Text(
                  tabela[spender].spent.toString() + " Mb",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: selecionadas.contains(tabela[spender]),
                selectedTileColor: Colors.indigo.shade50,
                onLongPress: () {
                  setState(() {
                    (selecionadas.contains(tabela[spender]))
                        ? selecionadas.remove(tabela[spender])
                        : selecionadas.add(tabela[spender]);
                  });
                },
                onTap: () => showDetails(tabela[spender]),
              ),
            ),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favorites.saveAll(selecionadas);
                clearSelecionadas();
              },
              icon: Icon(Icons.stars_sharp),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,


    );
  }
}
