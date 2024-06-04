import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'test app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer player = AudioPlayer();

  // this mp3 is 4:09 in duration - confirmed by playback as well as ffmpeg
  ProgressiveAudioSource audioSource = ProgressiveAudioSource(Uri.parse(
      "https://appdata.jesuslifetogether.com/appdatafiles/mp3s/audio/1164_lilies_sparrows_dont_have_energy_leaks/las05t_the_conservation_of_energy.mp3"));

  @override
  void initState() {
    super.initState();
    player.setAudioSource(audioSource);
    player.load();
    player.play();

    player.durationStream.listen((duration) {
      print("duration is ${player.duration} - should be 4:09");
    });
  }

  seekToNewPosition() async {
    // After seeking to 120s, it starts playing roughly at the 30s mark
    // 120s is outside of what is behind the buffered position initially
    await player.seek(const Duration(seconds: 120));
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'this is a test',
            ),
            FilledButton(
                onPressed: () async {
                  await seekToNewPosition();
                },
                child: const Text("Press me immediately"))
          ],
        ),
      ),
    );
  }
}
