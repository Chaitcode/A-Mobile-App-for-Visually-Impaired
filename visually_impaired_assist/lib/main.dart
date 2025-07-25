import 'package:flutter/material.dart';
import 'screens/object_detection_screen.dart';
import 'screens/ocr_screen.dart';
import 'screens/caption_screen.dart';
import 'screens/activity_recognition_screen.dart';  // Import the new screen
import 'package:route_transitions/route_transitions.dart';
import 'colors.dart';

void main() {
  runApp(VisuallyAssistApp());
}

bool _isLoading = false;

class VisuallyAssistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  Widget buildButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon),
      label: Text(label, style: TextStyle(fontSize: 18)),
      onPressed: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: secondary,
        title: const Row(
          children: [
            Icon(Icons.assistant_sharp, color: Colors.white),
            SizedBox(width: 8.0), // Adjust the spacing between icon and text
            Text('Visual Assist',style: TextStyle(color: Colors.white)),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLargeButton(
                  context,
                  label: "🧠 Object Detection",
                  screen: ObjectDetectionScreen(),
                  color: Colors.pinkAccent
                ),
                const SizedBox(height: 30),

                buildLargeButton(
                  context,
                  label: "📖 Text Recognition",
                  screen: OCRScreen(),
                  color: Colors.white30
                ),
                const SizedBox(height: 30),

                buildLargeButton(
                  context,
                  label: "🖼️ Image Captioning",
                  screen: CaptionScreen(),
                  color: Colors.orange
                ),
                const SizedBox(height: 30),

                // buildLargeButton(
                //   context,
                //   label: "🎥 Activity Recognition",
                //   screen: ActivityRecognitionScreen(),
                //   color: Colors.purpleAccent
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLargeButton(
      BuildContext context, {
        required String label,
        required Widget screen,
        required Color color,  // Add color parameter
      }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          slideRightWidget(newPage: screen, context: context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

}
