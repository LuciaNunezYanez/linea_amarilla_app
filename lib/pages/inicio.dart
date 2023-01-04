import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linea_amarilla/blocs/login/login_bloc.dart';
import 'package:linea_amarilla/blocs/share_pref/login.preferences.dart';
import 'package:linea_amarilla/widgets/drawer.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/fondo.JPG",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Inicio",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 247, 209, 63),
        ),
        body: Container(),
        drawer: DrawerPrincipal(),
      ),
    ]);
  }
}
