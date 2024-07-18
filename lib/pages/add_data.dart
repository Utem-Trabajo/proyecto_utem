import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:proyecto_utem/settings/gender_selector.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  int? selectedWeight;
  int? selectedHeight;
  int? selectedGoalWeight;

  List<int> weightOptions = List.generate(141, (index) => 10 + index);
  List<int> heightOptions = List.generate(101, (index) => 100 + index);
  List<int> goalWeightOptions = List.generate(141, (index) => 10 + index);

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
              'Rellene la siguiente información: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                GenderSelector(context, genderController);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: genderController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Género',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: birthDateController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    birthDateController.text = formattedDate;
                  });
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Fecha de Nacimiento',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<int>(
                dropdownColor: Colors.black,
                value: selectedWeight,
                onChanged: (int? value) {
                  setState(() {
                    selectedWeight = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: weightOptions.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: SizedBox(
                      width: 60.0,
                      child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<int>(
                dropdownColor: Colors.black,
                value: selectedHeight,
                onChanged: (int? value) {
                  setState(() {
                    selectedHeight = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: heightOptions.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: SizedBox(
                      width: 60.0,
                      child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<int>(
                dropdownColor: Colors.black,
                value: selectedGoalWeight,
                onChanged: (int? value) {
                  setState(() {
                    selectedGoalWeight = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Objetivo de Peso (kg)',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: goalWeightOptions.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: SizedBox(
                      width: 60.0,
                      child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
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
                  validateAndSaveData();
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

  void validateAndSaveData() {
    if (nameController.text.isEmpty ||
        genderController.text.isEmpty ||
        birthDateController.text.isEmpty ||
        selectedWeight == null ||
        selectedHeight == null ||
        selectedGoalWeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Debes ingresar todos los datos.'),
        ),
      );
    } else {
      print('Verificando y guardando datos...');
      saveData();
    }
  }

  Future<void> saveData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DateTime selectedDate =
          DateFormat('dd/MM/yyyy').parse(birthDateController.text);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'datosIngresados': true,
        'name': nameController.text,
        'gender': genderController.text,
        'birthDate': DateFormat('dd/MM/yyyy').format(selectedDate),
        'weight': selectedWeight.toString(),
        'height': selectedHeight.toString(),
        'goalWeight': selectedGoalWeight.toString(),
      });
      print('Datos guardados correctamente.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Datos guardados correctamente.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, "/page4", (route) => false);
    }
  }
}
