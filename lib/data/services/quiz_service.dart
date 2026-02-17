import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/questions_model.dart';

class QuizService {

  Future<List<QuestionModel>> fetchQuestions({
    required int limit,
    required String difficulty,
  }) async {

    final url =
        "https://the-trivia-api.com/api/questions?limit=$limit&difficulty=$difficulty";

    print("=========== API CALL STARTED ===========");
    print("Request URL: $url");

    print("Data length is: $limit");
    print("Diffculty Level: $difficulty");

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("API Response Success");

        final List<dynamic> data = jsonDecode(response.body);

        print("Total Questions Received: ${data.length}");

        return data.map((e) => QuestionModel.fromJson(e)).toList();
      } else {
        print("Server Error");
        print("Response Body: ${response.body}");

        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("=========== API ERROR OCCURRED ===========");
      print("Error Type: ${e.runtimeType}");
      print("Error Message: $e");
      print("StackTrace: $stackTrace");
      throw Exception("API Failed: $e");
    } finally {
      print("=========== API CALL COMPLETED ===========");
    }
  }
}
