import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linea_amarilla/blocs/registro/registro_bloc.dart';

// Controladores del formulario
var nombreRefController = TextEditingController();
var paternoRefController = TextEditingController();
var maternoRefController = TextEditingController();
var parentescoRefController = TextEditingController();
var telefonoRefController = TextEditingController();

var calleRefController = TextEditingController();
var numExtRefController = TextEditingController();
var numIntRefController = TextEditingController();
var coloniaRefController = TextEditingController();
var cpRefController = TextEditingController();

class CardReferencias extends StatefulWidget {
  @override
  State<CardReferencias> createState() => _CardReferenciasState();
}

class _CardReferenciasState extends State<CardReferencias> {
  final GlobalKey<FormState> _keyFormReferencias = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var blocRegistro = BlocProvider.of<RegistroBloc>(context);

    imagenCollapsed() {
      return SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: const Center(
                child: Text(
              'REFERENCIAS (Opcional)',
              style: TextStyle(fontSize: 16),
            )),
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/inf_referencias.jpg"),
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat),
              color: Colors.yellow[200],
              shape: BoxShape.rectangle,
            ),
          ));
    }

    contenidoCollapsed() {
      return Container();
    }

    contenidoExpanded() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                TextFormField(
                  controller: nombreRefController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.face),
                    hintText: 'Nombre (s)',
                  ),
                  onChanged: (value) {
                    blocRegistro.add(OnGuardarReferencia(nombre_ref: value));
                  },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Por favor ingrese su nombre';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: paternoRefController,
                  decoration: const InputDecoration(
                    hintText: 'Apellido paterno',
                    icon: Icon(Icons.fingerprint),
                  ),
                  onChanged: (value) {
                    blocRegistro
                        .add(OnGuardarReferencia(ap_paterno_ref: value));
                  },
                ),
                TextFormField(
                  controller: maternoRefController,
                  decoration: const InputDecoration(
                    hintText: 'Apellido materno',
                    icon: Icon(Icons.badge_outlined),
                  ),
                  onChanged: (value) {
                    blocRegistro
                        .add(OnGuardarReferencia(ap_materno_ref: value));
                  },
                ),
                TextFormField(
                  controller: parentescoRefController,
                  decoration: const InputDecoration(
                    hintText: 'Parentesco',
                    icon: Icon(Icons.family_restroom),
                  ),
                  onChanged: (value) {
                    blocRegistro
                        .add(OnGuardarReferencia(parentesco_ref: value));
                  },
                ),
                TextFormField(
                  controller: telefonoRefController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Teléfono',
                    icon: Icon(Icons.phone),
                  ),
                  onChanged: (value) {
                    blocRegistro.add(OnGuardarReferencia(telefono_ref: value));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: calleRefController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.add_road),
                    hintText: 'Calle',
                  ),
                  onChanged: (value) {
                    blocRegistro.add(OnGuardarReferencia(calle_ref: value));
                  },
                ),
                TextFormField(
                  controller: numExtRefController,
                  decoration: const InputDecoration(
                    hintText: 'Número exterior',
                    icon: Icon(Icons.pin),
                  ),
                  onChanged: (value) {
                    blocRegistro
                        .add(OnGuardarReferencia(numero_exterior_ref: value));
                  },
                ),
                TextFormField(
                  controller: numIntRefController,
                  decoration: const InputDecoration(
                    hintText: 'Número interior',
                    icon: Icon(Icons.money_outlined),
                  ),
                  onChanged: (value) {
                    blocRegistro
                        .add(OnGuardarReferencia(numero_interior_ref: value));
                  },
                ),
                TextFormField(
                  controller: coloniaRefController,
                  decoration: const InputDecoration(
                    hintText: 'Colonia',
                    icon: Icon(Icons.maps_home_work),
                  ),
                  onChanged: (value) {
                    blocRegistro.add(OnGuardarReferencia(colonia_ref: value));
                  },
                ),
                TextFormField(
                  controller: cpRefController,
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Código postal',
                    icon: Icon(Icons.markunread_mailbox),
                  ),
                  onChanged: (value) {
                    blocRegistro.add(OnGuardarReferencia(cp_ref: value));
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Form(
            key: _keyFormReferencias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Encabezado
                // Expandable(
                //   collapsed: encabezadoCollapsed(),
                //   expanded: encabezadoCollapsed(),
                // ),
                // Imagen
                Expandable(
                  collapsed: imagenCollapsed(),
                  expanded: imagenCollapsed(),
                ),
                // Contenido
                Expandable(
                  collapsed: contenidoCollapsed(),
                  expanded: contenidoExpanded(),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller =
                            ExpandableController.of(context, required: true)!;
                        return TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child: Text(
                            controller.expanded
                                ? "TERMINAR Y ENVIAR REGISTRO"
                                : "LLENAR",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (controller.expanded) {
                              // Comprobar llenado
                              if (_keyFormReferencias.currentState!
                                  .validate()) {
                                BlocProvider.of<RegistroBloc>(context)
                                    .add(OnEnviarRegistro());
                                controller.toggle();
                              }
                            } else {
                              controller.toggle();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
