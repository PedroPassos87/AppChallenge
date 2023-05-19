import 'package:challenge_app/repository/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();

    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(0.7),

      appBar: AppBar(
        title: Text('Conta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Text('Seu Plano:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              subtitle: Text(
                conta.capacidade.toString(),
                style: TextStyle(fontSize: 30, color: Colors.deepPurple[900]),
              ),
              trailing: IconButton(
                onPressed: updateCapacidade,
                icon: Icon(Icons.production_quantity_limits,color: Colors.white,size: 40,),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  updateCapacidade() async {
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.capacidade.toString();

    AlertDialog dialog = AlertDialog(
      title: Text('Atualizar capacidade'),
      content: Form(
        key: form,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return 'Informe o seu plano';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
        TextButton(onPressed: () {
          if(form.currentState!.validate()){
            conta.setCapacidade(double.parse(valor.text));
            Navigator.pop(context);
          }
        }, child: Text('Salvar')),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
