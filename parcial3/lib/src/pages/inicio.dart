import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class inicio extends StatefulWidget {
  static String id = 'inicio';

  @override
  _inicioState createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  List<capitanes> _capitanes = [];

  @override
  Widget build(BuildContext context) {
    getCapitanes();
    var lenght = _capitanes.length;
    print("largo: " + lenght.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Center(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _TxtBienvenida(),
              SizedBox(height: 15.0),
              //_buttonAddList(),
              //Tabla que contendrá los items
              Table(
                  //border: TableBorder.all(color: Colors.black),
                  columnWidths: {
                    0: FixedColumnWidth(100.0),
                  }, children: [
                //Cada TableRow es una fila para la tabla
                TableRow(children: [
                  SizedBox(height: 15.0),
                ]),
                //For para simular items solo usando 1 solo metodo
                for (var i = 0; i < lenght; i++)
                  TableRow(children: [
                    _buttonItem(_capitanes[i].nombre),
                  ]),
              ]),
              SizedBox(height: 15.0),
              //_buttonLogout(),
            ],
          ),
        ),
      ),
    );
  }

  void getCapitanes() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Capitanes");

    QuerySnapshot cap = await collectionReference.get();

    if (cap.docs.length != 0) {
      for (var doc in cap.docs) {
        print("datos: " + doc.data().toString());
        //print("nombre: " + doc.get("nombre").toString());
        var nombre = doc.get("nombre").toString();
        var id = doc.get("id").toString();
        var Equipo_id = doc.get("Equipo_id").toString();
        _capitanes.add(capitanes(nombre, id, Equipo_id));
      }
    }
  }

  Widget _TxtBienvenida() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Text(
        'Todos los capitanes registrados.',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }

  Widget _buttonItem(String nombre) {
    String ii = nombre;
    print("Entró al ciclo for");
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Entrenador: ' + ii),
                  Icon(Icons.logout),
                ]),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Colors.deepPurple[400],
          onPressed: () {
            //Navigator.of(context).pop();
          });
    });
  }
}

class capitanes {
  String nombre = "";
  String id = "";
  String Equipo_id = "";

  capitanes(nombre, id, Equipo_id) {
    this.nombre = nombre;
    this.id = id;
    this.Equipo_id = Equipo_id;
  }
}
