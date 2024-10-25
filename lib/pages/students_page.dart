import 'package:flutter/material.dart';
import 'package:json_read_compressed/CURD/read/list_students.dart';

//Tip select a line of text and press f2 to replace bulk stateful widget
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<Map<String, dynamic>>> futureList;

  @override
  void initState() {
    super.initState();
    futureList = fetchStudents(); //..........replace fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'), //........replace
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ListTile(
                leading: const Icon(Icons.face_6, color: Colors.blue),
                title: Text(
                  item['name'], //.............replace
                  style: const TextStyle(
                      color: Color.fromARGB(255, 47, 130, 199),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Roll No: ${item['roll_no']}\nPhone: ${item['phone']}'), //.........replace
                trailing: Text(
                  'id: ${item['id']}',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}
