import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData3 extends StatefulWidget {
  const AddData3({Key? key});

  @override
  State<AddData3> createState() => _AddData3State();
}

class _AddData3State extends State<AddData3> {
  String? selectedLevel;

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
              '¿Cuál es tu experiencia practicando musculación?',
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
                    'Principiante',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Aumentar el tamaño muscular.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Principiante',
                  groupValue: selectedLevel,
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text(
                    'Intermedio',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Reducir el porcentaje de grasa y definir músculos.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Intermedio',
                  groupValue: selectedLevel,
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text(
                    'Avanzado',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Reducir el peso corporal total.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Avanzado',
                  groupValue: selectedLevel,
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value;
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
                  // Validar si se ha seleccionado un nivel
                  if (selectedLevel != null) {
                    print('Nivel seleccionado: $selectedLevel');
                    saveData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, selecciona un nivel.'),
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
            'SelectedLevel': selectedLevel,
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
      Navigator.pushNamedAndRemoveUntil(context, "/page6", (route) => false);
    }
  }
}
