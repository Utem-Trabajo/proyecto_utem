import 'package:flutter/material.dart';
import 'package:proyecto_utem/settings/videoplayer.dart'; // Asegúrate de importar correctamente el widget VideoPlayerWidget

class Cardio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos de Cardio'),
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        foregroundColor: Colors.white,
      ),
      backgroundColor:
          Color.fromARGB(255, 34, 34, 34), // Cambia el color de fondo aquí
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250, // Ancho fijo para todos los botones
              child: ElevatedButton(
                onPressed: () {
                  navigateToVideoPlayer(
                      context, 'assets/Escaleras.mp4', 'Remo con tomada ancha');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Escaleras'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho fijo para todos los botones
              child: ElevatedButton(
                onPressed: () {
                  navigateToVideoPlayer(
                      context, 'assets/Eliptica.mp4', 'Eliptica');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Eliptica'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho fijo para todos los botones
              child: ElevatedButton(
                onPressed: () {
                  navigateToVideoPlayer(
                      context, 'assets/Bicicleta.mp4', 'Bicicleta');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Bicicleta'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToVideoPlayer(
      BuildContext context, String videoUrl, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerWidget(
          videoUrl: videoUrl,
          description: description,
          repetitionOptions: [
            RepetitionOption(
              description: '15 Minutos',
              value: '15',
            ),
            RepetitionOption(
              description: '20 Minutos',
              value: '20',
            ),
            RepetitionOption(
              description: '30 Minutos',
              value: '30',
            ),
          ],
        ),
      ),
    );
  }
}
