import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RepetitionOption {
  final String description;
  final String value;

  RepetitionOption({
    required this.description,
    required this.value,
  });
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String description;
  final List<RepetitionOption> repetitionOptions;

  const VideoPlayerWidget({
    required this.videoUrl,
    required this.description,
    required this.repetitionOptions,
    Key? key,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool _isStarted = false;
  RepetitionOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 34, 34), // Cambia el color de fondo aquí
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              style: TextStyle(fontSize: 18, color: Colors.white), // Color blanco para el texto de la descripción
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          // Repetitions radio buttons
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.repetitionOptions.map((option) {
              return RadioListTile<String>(
                title: Text(
                  option.description,
                  style: TextStyle(color: Colors.white), // Color blanco para el texto de las opciones
                ),
                value: option.value,
                groupValue: _selectedOption?.value,
                onChanged: _isStarted
                    ? null
                    : (value) {
                        setState(() {
                          _selectedOption = option;
                        });
                      },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Start/Finish button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white, // Color blanco para el texto del botón
            ),
            onPressed: () {
              setState(() {
                if (_isStarted) {
                  _isStarted = false;
                  _isPlaying = false;
                  _videoController.pause();
                  _selectedOption = null;
                } else {
                  if (_selectedOption != null) {
                    _isStarted = true;
                    _isPlaying = true;
                    _videoController.play();
                  } else {
                    // Mostrar un mensaje o manejar el caso donde no se selecciona ninguna opción
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Seleccione una repetición antes de comenzar.',
                          style: TextStyle(color: Colors.white), // Color blanco para el texto del SnackBar
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              });
            },
            child: Text(
              _isStarted ? 'Finalizar' : 'Comenzar',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          // Play/Pause button
        ],
      ),
    );
  }
}
