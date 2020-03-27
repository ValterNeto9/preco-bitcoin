import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Future<Map> _obterPreco() async{
    String _url = "https://blockchain.info/ticker";
    http.Response response = await http.get(_url);

    return json.decode(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _obterPreco(),
        builder: ( context, snapshot ){
          String _preco;
          switch( snapshot.connectionState ){
            case ConnectionState.none:
              print('none');
              break;
            case ConnectionState.waiting:
              print('Carregando...');
              _preco = 'Carregando...';
              break;
            case ConnectionState.active:
              print('active');
              break;
            case ConnectionState.done:
              if( snapshot.hasError ){
                _preco = 'Erro ao recuperar os dados';
              } else {
                double resultado = snapshot.data["BRL"]["buy"];
                _preco = resultado.toString();
              }
          }

          return this._geraInterface( _preco );
        }
    );
  }

  Widget _geraInterface( String _preco ){
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
                    "R\$ $_preco ",
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
