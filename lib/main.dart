import 'package:flutter/material.dart';
import 'package:video_recorder/videoRecorderScreen.dart';

void main() {
  runApp(VideoRecorderApp());
}

class VideoRecorderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Recorder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoRecorderScreen(),
    );
  }
}
