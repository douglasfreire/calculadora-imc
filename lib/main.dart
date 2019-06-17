import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String infoText = "Informe seus dados";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados";
      formkey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        infoText = "Abaixo do peso {${imc.toStringAsPrecision(3)}}";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso ideal {${imc.toStringAsPrecision(3)}}";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Levemente acima do peso {${imc.toStringAsPrecision(3)}}";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Obesidade grau I {${imc.toStringAsPrecision(3)}}";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade grau II {${imc.toStringAsPrecision(3)}}";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Obesidade grau III {${imc.toStringAsPrecision(3)}}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: resetFields,
            )
          ],
        ),
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso(kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: weightController,
                  validator: (value){
                    if (value.isEmpty){
                      return "insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: heightController,
                   validator: (value){
                    if (value.isEmpty){
                      return "insira sua altura!";
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(formkey.currentState.validate()){
                            calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                        ),
                        color: Colors.greenAccent,
                      ),
                    )),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
