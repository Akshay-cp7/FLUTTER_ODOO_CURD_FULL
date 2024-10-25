import 'package:http/http.dart' as http;
import 'package:json_read_compressed/fl_odoo_conf.dart';
import 'dart:convert';

Future<void> createFaculty(Map<String, dynamic> facultyData) async {
  final response = await http.post(
    Uri.parse(crtFaculty),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(facultyData),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to create facu: ${response.reasonPhrase}');
  }
}
