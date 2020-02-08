import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String _preco = "0";
  
  void _obterPreco() async{
    String _url = "https://blockchain.info/ticker";
    http.Response response = await http.get(_url);

    Map<String, dynamic> res = json.decode(response.body);

    setState(() {
      _preco = res["BRL"]["buy"].toString();
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.all(30),
                child: Text( 
                  "R\$ ${ _preco }",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                )
              ),
              RaisedButton(
                onPressed: _obterPreco,
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
