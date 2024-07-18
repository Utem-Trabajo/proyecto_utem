import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Botón flotante para navegar a la página de inicio de sesión
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/page2');
        },
        child:
            const Icon(Icons.navigate_next), // Icono de flecha hacia adelante
      ),
      backgroundColor: const Color.fromARGB(255, 34, 34, 34), // Color de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenedor para mostrar el logo
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Forma del contenedor (círculo)
                image: DecorationImage(
                  image: AssetImage(
                      'assets/Logo.jpeg'), // Ruta de la imagen del logo
                  fit:
                      BoxFit.cover, // Ajuste de la imagen dentro del contenedor
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio vertical
            // Texto de bienvenida
            Text(
              '¡Bienvenid@ a FenarozCoach!',
              style: TextStyle(
                fontSize: 25.0, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Peso de la fuente (negrita)
                color: Colors.deepPurpleAccent, // Color del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
