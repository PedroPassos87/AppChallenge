import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../models/posicao.dart';
import '../models/spender.dart';

class ContaRepository extends ChangeNotifier{
  late Database db;
  List<Posicao> _armazenamento = [];
  double _capacidade = 0;

  get capacidade => _capacidade;
  List<Posicao> get armazenamento => _armazenamento;

  ContaRepository(){
    _initRepository();
  }

  _initRepository() async{
    await _getCapacidade();
  }


  setCapacidade(double valor) async{
    db = await DB.instance.database;
    db.update('conta', {
      'capacidade': valor,
    });
    _capacidade = valor;
    notifyListeners();
  }

  _getCapacidade() async{
    db = await DB.instance.database;
    List conta = await db.query('conta',limit: 1);
    _capacidade = conta.first['capacidade'];
    notifyListeners();
  }

  setlimite(Spender spender, double valor) async{
    spender.limit = valor;
  }

  Future<double?> getLimite(Spender spender) async {
    final db = await DB.instance.database;
    final result = await db.query(
      'myApps',
      columns: ['limite'],
      where: 'name = ?',
      whereArgs: [spender.name],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return double.parse(result.first['limite']);
    } else {
      return null;
    }
  }

}