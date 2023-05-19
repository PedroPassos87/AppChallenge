import 'package:challenge_app/pages/spender_page.dart';
import 'package:flutter/material.dart';
import 'armazenamento_page.dart';
import 'config_page.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: actualPage);
  }

  setActualPage(page){
    setState(() {
      actualPage = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(

        controller: pc,
        children: [
          SpenderPage(),
          ArmazenamentoPage(),
          FavoritesPage(),
          ConfigPage(),

        ],
        onPageChanged: setActualPage,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          currentIndex: actualPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list,color: Colors.deepPurpleAccent), label: 'All',),
            BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined,color: Colors.deepPurpleAccent), label:'Overview'),
            BottomNavigationBarItem(icon: Icon(Icons.stars_sharp,color: Colors.deepPurpleAccent), label:'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.deepPurpleAccent), label:'Account'),
          ],
          onTap: (page) {
            pc.animateToPage(
              page,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
