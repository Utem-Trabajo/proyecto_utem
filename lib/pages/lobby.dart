import 'package:flutter/material.dart';
import 'perfil.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(
        title: Text('Lobby'),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: Colors.white,
                size:
                    50), // Icono de usuario, puedes cambiarlo por cualquier otro icono de tu elección
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MiPerfil()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '¡Hola!, ¿Qué tipo de ejercicios quieres hacer hoy?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/page8');
              },
              child: _buildContainerWithImage(
                'assets/Musculatura.jpg', // Ruta de la imagen
                'Muscular',
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/page9');
              },
              child: _buildContainerWithImage(
                'assets/Cardio.jpg', // Ruta de la imagen
                'Cardio',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerWithImage(String imagePath, String text) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), // Esquinas redondeadas
        image: DecorationImage(
          image: AssetImage(imagePath), // Ruta de la imagen
          fit: BoxFit.cover, // Ajuste de la imagen dentro del contenedor
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
