// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_recorder/videoplayer.dart';

class VideoRecorderScreen extends StatefulWidget {
  @override
  _VideoRecorderScreenState createState() => _VideoRecorderScreenState();
}

class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
  List<File> _videos = [];
  bool skeletonValue = true;

  Future<void> _recordVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _videos.add(File(pickedFile.path));
      });
    }
  }

  void _deleteVideo(File video) {
    setState(() {
      _videos.remove(video);
    });
  }

  void _playVideo(File video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: video),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      skeletonValue = false;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: skeletonValue,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Video Recorder App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: _recordVideo,
              child: Text('Open Camera'),
            ),
            Expanded(
              child: _videos.isEmpty
                  ? Center(child: Text('No video found'))
                  : ListView.builder(
                      itemCount: _videos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Video ${index + 1}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () => _playVideo(_videos[index]),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteVideo(_videos[index]),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
