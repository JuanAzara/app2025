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
          title: const Text('Add a new address',
          style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700, // Peso regular
                letterSpacing: 0.74,
              ),
          ),
        ),
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 211, 147),
                ),
                child: const Center(
                  child: Text(
                    'Free shipping on all orders',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '*Country/Region',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Germany',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Full Name',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Juanito Azara',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),
           
Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Street Name',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Street Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),
           
Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'House Number',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'House Number',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Additional Address (Optional)',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Superficie 3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'PLZ',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'PLZ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Town/City',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Town City',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 103, 103),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'State/Province',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 155, 57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
