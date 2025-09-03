import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Textos según Material Design'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            // Título H1
            Text(
              'Título Principal (H1)',
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.w300, // Peso ligero (light)
                letterSpacing: -1.5,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Header 2',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w300, // Peso ligero (light)
                letterSpacing: -0.83,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Header 3',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Header 4',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 0.74,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Header 5',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Header 6',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500, // Peso medium
                letterSpacing: 0.75,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Subtitulo 1',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 0.94,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Subtitulo 2',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 0.71,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Body 1',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 3.13,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Body 2',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 1.79,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Button',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500, // Peso medium
                letterSpacing: 8.93,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Caption',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 3.33,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Caption',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400, // Peso regular
                letterSpacing: 15,
              ),
            ),
            SizedBox(height: 24),



          ],  
        ),
      ),
    );
  }
}