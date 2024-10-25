import 'package:flutter/material.dart';
import 'package:json_read_compressed/pages/faculty_page.dart';
import 'package:json_read_compressed/pages/students_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            studentButton(context),
            facultyButton(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FacultyListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Set the button color to blue
                    minimumSize: const Size(double.infinity, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Batch',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding facultyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FacultyListScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Set the button color to blue
            minimumSize: const Size(double.infinity, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text(
          'Faculties',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  Widget studentButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentListScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Set the button color to blue
            minimumSize: const Size(double.infinity, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text(
          'Students',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
