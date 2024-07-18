import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_utem/connection/auth_google.dart'; // Importa el archivo que contiene la lógica de autenticación con Google

class InicioSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 34, 34, 34), // Color de fondo del Scaffold
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de tu aplicación
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
            const Text(
              'Para empezar es necesario que inicies sesión',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Espacio vertical
            ElevatedButton(
              onPressed: () async {
                print('Iniciando sesión con Google...');

                // Llama a la función para iniciar sesión con Google definida en AuthUser
                User? user = await AuthUser.loginGoogle();

                if (user != null) {
                  print('Usuario autenticado: ${user.uid}');

                  // Verifica si el usuario ya ha ingresado datos
                  bool hasEnteredData =
                      await AuthUser.hasUserDataEntered(user.uid);
                  print('¿Datos ingresados?: $hasEnteredData');

                  if (hasEnteredData) {
                    // Si ya ingresó datos, navegar a la página principal ("/page7")
                    print(
                        'Ya tiene datos ingresados. Navegando a la página principal.');
                    Navigator.pushNamed(context, "/page7");
                  } else {
                    // Si no ha ingresado datos, navegar a la página de ingreso de datos ("/page3")
                    print(
                        'No tiene datos ingresados. Navegando a la página de ingreso de datos.');
                    Navigator.pushNamed(context, "/page3");
                  }
                } else {
                  // Manejar caso de error de inicio de sesión
                  print('Inicio de sesión fallido.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Inicio de sesión fallido'),
                    ),
                  );
                }
              },
              // Texto del botón de inicio de sesión con Google
              child: Text(
                'Iniciar Sesión con Google',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20), // Espacio vertical
          ],
        ),
      ),
    );
  }
}
