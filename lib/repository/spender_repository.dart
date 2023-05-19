import 'package:challenge_app/models/spender.dart';
import 'package:flutter/cupertino.dart';

class SpenderRepository extends ChangeNotifier{

  static bool isSorted = false;


  static List<Spender> tabela = [
    Spender(
      icon: 'assets/images/spotify.png',
      name: 'Spotify',
      spent: 100.5,
      limit: 200

    ),
    Spender(
      icon: 'assets/images/youtube.png',
      name: 'Youtube',
      spent: 377.9,

    ),
    Spender(
      icon: 'assets/images/navegador.png',
      name: 'Navegadores',
      spent: 37.2
    ),
    Spender(
        icon: 'assets/images/twitch.png',
        name: 'Twitch',
        spent: 1020.52
    ),
    Spender(
        icon: 'assets/images/instagram.png',
        name: 'Instagram',
        spent: 502.3
    ),
  ];

  sort(){

    if(!isSorted){
      tabela.sort((Spender a,Spender b)=> a.name.compareTo(b.name));
    }
    else{
      tabela.reversed.toList();
    }
    notifyListeners();
  }
}
