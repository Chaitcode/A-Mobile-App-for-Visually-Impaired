import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';

import 'package:visually_impaired_assist/host_ip.dart';
import 'package:visually_impaired_assist/colors.dart';

class ActivityRecognitionScreen extends StatefulWidget {
  @override
  _ActivityRecognitionScreenState createState() => _ActivityRecognitionScreenState();
}

class _ActivityRecognitionScreenState extends State<ActivityRecognitionScreen> {
  File? _video;
  String _activity = '';
  final picker = ImagePicker();
  final tts = FlutterTts();
  bool _isLoading = false;

  // Function to pick video either from camera or gallery
  Future pickVideo(ImageSource source) async {
    final pickedFile = await picker.pickVideo(source: source);
    if (pickedFile == null) return;

    setState(() {
      _video = File(pickedFile.path);
      _isLoading = true; // Start loading while uploading video
    });

    await uploadVideo(_video!);

    setState(() {
      _isLoading = false; // Stop loading once the video upload is done
    });
  }

  // Function to upload video and receive activity recognition response
  Future uploadVideo(File video) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$ip/activity_recognition'), // Change with your backend IP
      );
      request.files.add(await http.MultipartFile.fromPath('video', video.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        final data = json.decode(resStr);
        setState(() => _activity = data['activity']);
        await tts.speak("Detected activity: $_activity");
      } else {
        setState(() => _activity = "Error: ${response.statusCode}");
        await tts.speak("Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _activity = "Exception: $e");
      await tts.speak("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: const Row(
          children: [
            Icon(Icons.video_camera_back, color: Colors.white),
            SizedBox(width: 8.0),
            Text('Activity Recognition', style: TextStyle(color: Colors.white)),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _video == null
                      ? const Center(child: Text("No video selected"))
                      : VideoPlayerWidget(file: _video!),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      label: const Text("Gallery", style: TextStyle(color: Colors.white)),
                      onPressed: _isLoading ? null : () => pickVideo(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text("Camera", style: TextStyle(color: Colors.white)),
                      onPressed: _isLoading ? null : () => pickVideo(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                  _activity,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for displaying and playing the video
class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({required this.file});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : const Center(child: CircularProgressIndicator());
  }
}
