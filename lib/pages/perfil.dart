import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MiPerfil extends StatefulWidget {
  const MiPerfil({Key? key}) : super(key: key);

  @override
  State<MiPerfil> createState() => _MiPerfilState();
}

class _MiPerfilState extends State<MiPerfil> {
  late User _currentUser; // Variable para almacenar el usuario actual
  TextEditingController _pesoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth
        .instance.currentUser!; // Obtener usuario actualmente autenticado
  }

  @override
  void dispose() {
    _pesoController.dispose();
    super.dispose();
  }

  void actualizarPeso(String nuevoPeso) async {
    // Actualizar el documento del usuario en Firestore
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.uid)
          .update({
        'weight': nuevoPeso,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Peso actualizado correctamente'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al actualizar el peso: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser.uid)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.exists == false) {
              return Text('No data found');
            }

            // Obtén los datos del documento
            var data = snapshot.data!.data() as Map<String, dynamic>;
            // Obtener y convertir los datos a double
            double pesoActual = double.tryParse(data['weight'] ?? '0.0') ?? 0.0;
            double metaPeso =
                double.tryParse(data['goalWeight'] ?? '0.0') ?? 0.0;

            // Calcular la diferencia de peso
            double diferenciaPeso = metaPeso - pesoActual;
            bool debePerderPeso = diferenciaPeso < 0;

            // Construir la interfaz de usuario
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nombre: ${data['name']}',
                    style:
                        TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 8),
                Text('Objetivo seleccionado: ${data['SelectedGoal']}',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 8),
                Text('Peso: ${data['weight']} kg',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 8),
                Text('Meta de peso: ${data['goalWeight']} kg',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 16),
                if (debePerderPeso)
                  Text(
                      'Debes perder ${-diferenciaPeso} Kg para alcanzar tu meta, ¡Ánimo!',
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                if (!debePerderPeso)
                  Text('Lograste tu peso ideal, ¡Felicitaciones!',
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Actualizar Peso'),
                          content: TextField(
                            controller: _pesoController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration:
                                InputDecoration(labelText: 'Nuevo Peso'),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Actualizar'),
                              onPressed: () {
                                String nuevoPeso = _pesoController.text.trim();
                                if (nuevoPeso.isNotEmpty) {
                                  actualizarPeso(nuevoPeso);
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Por favor ingresa un nuevo peso válido'),
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Actualizar Peso'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
