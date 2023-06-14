import 'package:audioplayers/audioplayers.dart';
import 'package:final_project/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isNext = false;

  @override
  void initState() {
    super.initState();
    setAudio();
    setupPlayerListeners();
  }

  Future<String> setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: 'assets/');
    var url;
    final songs = ["hiphop.mp3", "example.mp3"];
    var counter = 0;
    print(songs[counter]);
    if (isNext) {
      url = await player.load(songs[counter]);
      isNext = false;
    } else {
      url = await player.load('example.mp3');
    }
    counter++;
    audioPlayer.setUrl(url.path, isLocal: true);

    return url;
  }

  void setupPlayerListeners() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Kent Music",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("Burak KENT"),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                // Optionally, you can resume playing after seeking.
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration - position)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 50,
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: Icon(Icons.skip_next_sharp),
                    iconSize: 50,
                    onPressed: () async {
                      isNext = true;
                      final url = await setAudio();
                      audioPlayer.play(url);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}