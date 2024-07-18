import 'package:flutter/material.dart';
import 'package:proyecto_utem/settings/videoplayer.dart'; // Asegúrate de importar correctamente el widget VideoPlayerWidget

class Muscular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos de Musculatura'),
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
                      context, 'assets/Polea.mp4', 'Remo con tomada ancha');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: 20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Remo con tomada ancha'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho fijo para todos los botones
              child: ElevatedButton(
                onPressed: () {
                  navigateToVideoPlayer(
                      context, 'assets/Arms.mp4', 'Pull Over con Polea');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: 20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Pull over con polea'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho fijo para todos los botones
              child: ElevatedButton(
                onPressed: () {
                  navigateToVideoPlayer(
                      context, 'assets/LegCurl.mp4', 'Leg Curl');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: 20), // Aumenta el padding vertical para hacer el botón más grande
                  textStyle:
                      TextStyle(fontSize: 18), // Tamaño del texto del botón
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // Color de texto del botón
                ),
                child: Text('Leg Curl'),
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
              description: '4 Series de 5 Reps',
              value: '5',
            ),
            RepetitionOption(
              description: '4 Series de 10 Reps',
              value: '10',
            ),
            RepetitionOption(
              description: '4 Series de 15 Reps',
              value: '15',
            ),
          ],
        ),
      ),
    );
  }
}
