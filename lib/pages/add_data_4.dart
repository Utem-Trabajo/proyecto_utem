import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData4 extends StatefulWidget {
  const AddData4({Key? key});

  @override
  State<AddData4> createState() => _AddData4State();
}

class _AddData4State extends State<AddData4> {
  String? selectedGym;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Dónde entrenas habitualmente?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<String>(
                  title: const Text(
                    'Gimnasio Básico o casa',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Entrenamiento en casa o en un gimnasio básico.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'BasicGym',
                  groupValue: selectedGym,
                  onChanged: (value) {
                    setState(() {
                      selectedGym = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text(
                    'Gimnasio Avanzado',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Entrenamiento en un gimnasio avanzado.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'AdvancedGym',
                  groupValue: selectedGym,
                  onChanged: (value) {
                    setState(() {
                      selectedGym = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                color: Colors.deepPurple, // Color de fondo deep purple
              ),
              child: TextButton(
                onPressed: () {
                  // Validar si se ha seleccionado un lugar de entrenamiento
                  if (selectedGym != null) {
                    print('Lugar de entrenamiento seleccionado: $selectedGym');
                    saveData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Por favor, selecciona un lugar de entrenamiento.'),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'SelectedGym': selectedGym,
          },
          SetOptions(
              merge:
                  true)); // Utiliza merge: true para mantener datos existentes

      print('Datos guardados correctamente.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos guardados correctamente.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, "/page7", (route) => false);
    }
  }
}
