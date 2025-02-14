import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FlowiseService {
  final String _apiUrl =
      "https://chatbot.otto-miler-matulin.from.hr/api/v1/prediction/96cb4521-c73d-43a8-9161-b491423c1bfb";

  Future<String> queryFlowise(String question) async {
    try {
      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"question": question}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["text"] ?? "Odgovor nije dostupan";
      } else {
        throw Exception("Greška: ${response.statusCode}");
      }
    } on TimeoutException catch (_) {
      throw Exception("Zahtjev je istekao. Pokušajte ponovo.");
    } catch (e) {
      throw Exception("Dogodila se pogreška: $e");
    }
  }
}
