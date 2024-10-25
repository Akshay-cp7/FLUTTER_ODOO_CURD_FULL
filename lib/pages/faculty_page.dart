import 'package:flutter/material.dart';
import 'package:json_read_compressed/CURD/create/crt_faculty.dart';
import 'package:json_read_compressed/CURD/delete/del_faculty.dart';
import 'package:json_read_compressed/CURD/read/list_faculty.dart';
import 'package:json_read_compressed/CURD/update/upd_faculty.dart';

class FacultyListScreen extends StatefulWidget {
  const FacultyListScreen({super.key});

  @override
  State<FacultyListScreen> createState() => _FacultyListScreenState();
}

class _FacultyListScreenState extends State<FacultyListScreen> {
  late Future<List<Map<String, dynamic>>> futureList;

  @override
  void initState() {
    super.initState();
    futureList = fetchFaculty();
  }

  Future<void> _deleteFaculty(int id, String name) async {
    // Delete confirmation dialog
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $name?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await deleteFaculty(id);
        setState(() {
          futureList = fetchFaculty(); // Refresh the list after deletion
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Faculty deleted successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _editFaculty(
      int id, String currentName, String currentCode) async {
    final TextEditingController nameController =
        TextEditingController(text: currentName);
    final TextEditingController codeController =
        TextEditingController(text: currentCode);

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Faculty'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await updateFaculty(id, nameController.text, codeController.text);
        setState(() {
          futureList = fetchFaculty(); // Refresh the list after updating
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Faculty updated successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _createFaculty() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController codeController = TextEditingController();

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Faculty'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await createFaculty({
          'name': nameController.text,
          'code': codeController.text,
        });
        setState(() {
          futureList = fetchFaculty(); // Refresh the list after creation
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Faculty created successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createFaculty, // Call create faculty method
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Faculty List'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No faculty found.'));
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.face_6, color: Colors.blue),
                      title: Text(
                        item['name'],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 47, 130, 199),
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Code: ${item['code']}'),
                      trailing: Text(
                        'id: ${item['id']}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      onLongPress: () {
                        _deleteFaculty(item['id'], item['name']);
                      },
                      onTap: () {
                        _editFaculty(item['id'], item['name'], item['code']);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
