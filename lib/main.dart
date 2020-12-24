import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Calculadora IMC",
    home: Home()
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  GlobalKey <FormState> formKey = GlobalKey <FormState>();

  String _infoText = "Informe seus dados!";

  void _refreshFields(){
    setState(() {
      weightController.clear();
      heightController.clear();
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView (
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form (
          key: formKey,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Icon (
                Icons.person_outline, 
                size: 120.0, 
                color: Colors.green,
              ),
              TextFormField (
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty){
                    return "Informe seu Peso!";
                  }
                },
              ),
              TextFormField (
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty){
                    return "Informe sua Altura!";
                  }
                },
              ),
              Padding (
                padding: EdgeInsets.only(bottom: 15.0, top: 20.0),
                child: Container ( 
                  height: 50.0,
                  child: RaisedButton (
                    onPressed: () {
                      if(formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text (
                      "Calcular", 
                      style: TextStyle(color: Colors.white, fontSize: 22.0)
                    ),
                    color: Colors.green[400]
                  ),
                ),
              ),
              Text (
                "$_infoText", 
                style: TextStyle(color: Colors.green, fontSize: 22.0), 
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      )
    );
  }
}