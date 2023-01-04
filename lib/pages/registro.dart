import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linea_amarilla/blocs/registro/registro_bloc.dart';
import 'package:linea_amarilla/blocs/share_pref/login.preferences.dart';
import 'package:linea_amarilla/helpers/mostrar_alerta.dart';
import 'package:linea_amarilla/pages/inicio.dart';
import 'package:linea_amarilla/pages/login.dart';
import 'package:linea_amarilla/widgets/widgets.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  @override
  Widget build(BuildContext context) {
    var blocRegistro = BlocProvider.of<RegistroBloc>(context);

    return BlocListener<RegistroBloc, RegistroState>(
      listener: (context, state) async {
        if(state.registroExitoso > 0){
          // El registro ha sido exitoso.
          mostrarAlerta(context, 'Registro exitoso', 'Por favor inicie sesión', 'Aceptar', funcion: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
          },);          
          
        } else if (state.registroExitoso == -1){
          // Mostrar error, cerrar ventana y poner en 0 de nuevo
          mostrarAlerta(context, '', state.mensajeError, 'Ok');
          blocRegistro.add(OnCambiarRegistroExitoso(0));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "¡Quiero registrarme!",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 247, 209, 63),
        ),
        body: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.yellow,
            useInkWell: true,
          ),
          child: BlocBuilder<RegistroBloc, RegistroState>(
            builder: (context, state) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  (state.regInventario)
                      ? CardInformacionInventario()
                      : Container(),
                  (state.regPersonal) ? CardInformacionPersonal() : Container(),
                  (state.regDomicilio)
                      ? CardInformacionDireccion()
                      : Container(),
                  (state.regReferencias) ? CardReferencias() : Container(),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: _btnInfo(),
      ),
    );
  }

  Container _btnInfo() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[500])),
        child: const Text(
          '¿Cómo será utilizada mi información?',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }
}
