import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      String _infoText = "Informe os Dados";
  void _resetFields(){
    setState(() {
      weightController.text = '';
      heightController.text = '';
      _infoText =  "Informe os Dados";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calculate(){
    setState(() {
      double height = double.parse(heightController.text)/100;
      double weight = double.parse(weightController.text);
      double imc =  weight / (height*height);

      if(imc<18.6)
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";
      if(imc>=18.6 && imc <=24.9)
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      if(imc>=24.9 && imc <= 29.9)
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(2)})";
      if(imc>= 29.9 && imc <= 34.9)
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      if(imc>= 34.9 && imc <= 39.9)
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      if(imc > 39.9)
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child:Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso em Kg",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                controller: weightController,
                validator: (value){
                    if(value.isEmpty){
                      return "Insira um Peso!";
                    }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura em (cm)",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira uma Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child:   Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25),),
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25),)
            ],
          ),
        ),
      )
    );
  }
}
