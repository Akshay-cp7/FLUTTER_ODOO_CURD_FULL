import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_read_compressed/fl_odoo_conf.dart';

Future<void> updateFaculty(int id, String name, String code) async {
  final url = '$editFacultyUrl/$id'; // Ensure this URL is correct
  final response = await http.put(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      'code': code,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update faculty: ${response.reasonPhrase}');
  }
}
