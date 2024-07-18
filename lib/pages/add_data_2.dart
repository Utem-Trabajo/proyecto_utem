import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData2 extends StatefulWidget {
  const AddData2({Key? key});

  @override
  State<AddData2> createState() => _AddData2State();
}

class _AddData2State extends State<AddData2> {
  String? selectedGoal;

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
              '¿Cuál es tu objetivo?',
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
                    'Hipertrofia',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Aumentar el tamaño muscular.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Hipertrofia',
                  groupValue: selectedGoal,
                  onChanged: (value) {
                    setState(() {
                      selectedGoal = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text(
                    'Definición Muscular',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Reducir el porcentaje de grasa y definir músculos.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Definición Muscular',
                  groupValue: selectedGoal,
                  onChanged: (value) {
                    setState(() {
                      selectedGoal = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text(
                    'Perder Peso',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Reducir el peso corporal total.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  value: 'Perder Peso',
                  groupValue: selectedGoal,
                  onChanged: (value) {
                    setState(() {
                      selectedGoal = value;
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
                  // Validar si se ha seleccionado un objetivo
                  if (selectedGoal != null) {
                    print('Objetivo seleccionado: $selectedGoal');
                    saveData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, selecciona un objetivo.'),
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
            'SelectedGoal': selectedGoal,
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
      Navigator.pushNamedAndRemoveUntil(context, "/page5", (route) => false);
    }
  }
}
