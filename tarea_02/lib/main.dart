// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _altura = TextEditingController();
  var _peso = TextEditingController();
  double bmiCalculation = 0;
  bool _femaleButton = false;
  bool _maleButton = false;

  _clearTextFields() {
    _altura.clear();
    _peso.clear();
    _femaleButton = false;
    _maleButton = false;

    setState(() {});
  }

  _bmiCalculation() {
    var constPeso = double.parse(_peso.text);
    var constAltura = double.parse(_altura.text);

    bmiCalculation = constPeso / (constAltura * constAltura);

    if (_femaleButton == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Tu IMC es de: ${bmiCalculation.toStringAsFixed(2)}"),
              content: Text(
                  "Tabla de IMC para mujeres\n\nEdad    IMC Ideal \n15 a 20    18-19\n21 a 25    20-24\n26 a 30    21-25\n31 a 35    22-25\n36 a 39    23-27\n40 a 45    24-28\n46 a 50    25-29\n51 a 60    26-30\n   >60        27-31"),
            );
          });
    } else if (_maleButton == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Tu IMC es de: ${bmiCalculation.toStringAsFixed(2)}"),
              content: Text(
                  "Tabla de IMC para hombres\n\nEdad    IMC Ideal\n15 a 20      6-15\n21 a 25      8-17\n26 a 30    10-18\n31 a 35    12-19\n36 a 39    14-20\n40 a 45    16-21\n46 a 50    18-22\n51 a 60    20-23\n   >60        22-26"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: _clearTextFields,
              icon: Icon(Icons.delete),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ingrese sus datos para calcular el IMC",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    color: _femaleButton ? Colors.orange : Colors.black54,
                    onPressed: () {
                      setState(() {
                        _femaleButton = true;
                        _maleButton = false;
                      });
                    },
                    icon: Icon(Icons.female_sharp),
                    iconSize: 35,
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    color: _maleButton ? Colors.orange : Colors.black54,
                    onPressed: () {
                      setState(() {
                        _maleButton = true;
                        _femaleButton = false;
                      });
                    },
                    icon: Icon(Icons.male),
                    iconSize: 35,
                  )
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: _altura,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Ingresar altura (Metros)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _peso,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vertical_align_bottom_sharp,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Ingresar peso (Kg)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(child: Text("Calcular"), onPressed: _bmiCalculation)
          ])
        ],
      ),
    );
  }
}
