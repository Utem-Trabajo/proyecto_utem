import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_utem/pages/add_data.dart';
import 'package:proyecto_utem/pages/add_data_2.dart';
import 'package:proyecto_utem/pages/add_data_3.dart';
import 'package:proyecto_utem/pages/add_data_4.dart';
import 'package:proyecto_utem/pages/cardio.dart';
import 'package:proyecto_utem/pages/inicio.dart';
import 'package:proyecto_utem/pages/lobby.dart';
import 'package:proyecto_utem/pages/login.dart';
import 'package:proyecto_utem/pages/muscular.dart';
import 'package:proyecto_utem/pages/perfil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Inicialización con Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ejecución de la aplicación Flutter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Ruta inicial de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor:
                Colors.deepPurple), // Esquema de colores de la aplicación
        useMaterial3:
            true, // Utiliza Material3, que es parte del nuevo diseño de Material para Flutter
      ),
      routes: {
        '/': (BuildContext context) =>
            const Inicio(), // Ruta para la página de inicio
        '/page2': (BuildContext context) =>
            InicioSesion(), // Ruta para la página de inicio de sesión (login)
        '/page3': (BuildContext context) =>
            const AddData(), // Ruta para una página para añadir datos
        '/page4': (BuildContext context) =>
            const AddData2(), // Ruta para otra página para añadir datos
        '/page5': (BuildContext context) =>
            const AddData3(), // Ruta para otra página para añadir datos
        '/page6': (BuildContext context) =>
            const AddData4(), // Ruta para otra página para añadir datos
        '/page7': (BuildContext context) =>
            Lobby(), // Ruta para la página del lobby
        '/page8': (BuildContext context) =>
            Muscular(), // Ruta para la página de ejercicios musculares
        '/page9': (BuildContext context) => Cardio(),
        '/page10': (BuildContext context) =>
            const MiPerfil() // Ruta para la página de ejercicios cardiovasculares
      },
    );
  }
}
