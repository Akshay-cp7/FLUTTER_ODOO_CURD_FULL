import 'package:http/http.dart' as http;
import 'package:json_read_compressed/fl_odoo_conf.dart';

Future<void> deleteFaculty(int id) async {
  final url = '$dltFaculty/$id';
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Successfully deleted
    return; // Optionally return a success message or result
  } else {
    // Handle error
    throw Exception('Failed to delete faculty: ${response.reasonPhrase}');
  }
}
