import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linea_amarilla/blocs/login/login_bloc.dart';
import 'package:linea_amarilla/helpers/mostrar_alerta.dart';
import 'package:linea_amarilla/pages/inicio.dart';
import 'package:linea_amarilla/pages/registro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _keyFormLogin = GlobalKey<FormState>();
  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    var loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.add(OnCambiarIDPersona(0));

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.idPersona > 0) {
          // El login ha sido exitoso. Pasar a la pantalla principal.
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => InicioPage()));
        } else if (state.idPersona == -1){
          // Mostrar error, cerrar ventana y poner en 0 de nuevo
          mostrarAlerta(context, '','Por favor valide sus datos.', 'Ok');
          loginBloc.add(OnCambiarIDPersona(0));
        }
      },
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 247, 209, 63),
          child: Center(
            child: Card(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _keyFormLogin,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LINEA AMARILLA',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: correoController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Correo electrónico',
                            // icon: Icon(Icons.alternate_email),
                          ),
                        ),
                        TextFormField(
                          controller: contrasenaController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Contraseña',
                            // icon: Icon(Icons.password)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (correoController.text.isNotEmpty &&
                                contrasenaController.text.isNotEmpty) {
                              // Hacer login
                              BlocProvider.of<LoginBloc>(context).add(OnLogin(
                                  correoController.text,
                                  contrasenaController.text));
                            } else {
                              // Alerta de ingresar ambos campos
                              mostrarAlerta(context, '',
                                  'Por favor ingrese ambos campos', 'Ok');
                            }
                          },
                          child: Text(
                            'INICIAR SESIÓN',
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegistroPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: const Text(
                            '¡Quiero registrarme!',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
        // bottomNavigationBar:
        //     Container(color: Colors.grey[300], height: 30, child: Text('')),
      ),
    );
  }
}
