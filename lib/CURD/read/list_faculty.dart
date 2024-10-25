import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_read_compressed/fl_odoo_conf.dart';

Future<List<Map<String, dynamic>>> fetchFaculty() async {
  //........replace fetch name()
  final response = await http.get(Uri.parse(getFaculty));

  if (response.statusCode != 200) {
    throw Exception('Failed to load Faculty'); //.........replace this
  }

  final data = json.decode(response.body);
  return List<Map<String, dynamic>>.from(data[
      'faculty']); //..........Change it to json item name when url pasted on browser
}
