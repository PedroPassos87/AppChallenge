import 'package:challenge_app/models/spender.dart';
import 'package:challenge_app/repository/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SpenderDetailsPage extends StatefulWidget {
  Spender spender;

  SpenderDetailsPage({super.key, required this.spender});

  @override
  State<SpenderDetailsPage> createState() => _SpenderDetailsPageState();
}

class _SpenderDetailsPageState extends State<SpenderDetailsPage> {
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();
  late ContaRepository conta;
  late double aux;

  bool get isLimited => widget.spender.limit != null;

  limitar() async{

      //salvar o limite

      var limite = await conta.setlimite(widget.spender, double.parse(_value.text));
      widget.spender.limit = limite;

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Limite definido',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),);

  }

  @override
  Widget build(BuildContext context) {
    conta = Provider.of<ContaRepository>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),

      appBar: AppBar(
        title: Text(widget.spender.name),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.black],
          )),
          child: Column(
            children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:80,
                          child: Image.asset(
                            widget.spender.icon,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.deepPurple,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(

                            'Total gasto:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.spender.spent.toString() + 'Mb',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

              Column(
                children: [
                  Form(

                    key: _form,
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 24, right: 24, bottom: 5, top: 10),
                      child: TextFormField(
                        controller: _value,

                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                          filled: true, // Add this line
                          fillColor: Colors.white.withOpacity(0.2),
                          labelText: isLimited?'Limite: ${widget.spender.limit}':'Definir Limite',
                          prefixIcon: Icon(Icons.add_chart_outlined,color: Colors.white,),
                          suffix: Text(
                            'Mb',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            widget.spender.limit = null;
                            return 'Informe o valor do Limite';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(
                    onPressed: limitar,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      fixedSize: const Size(100, 50),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white.withOpacity(0.5), width: 2),
                              borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
