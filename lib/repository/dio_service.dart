import 'package:dio/dio.dart';

class DioService {
  DioService._();

  static final DioService _instance = DioService._();

  factory DioService() => _instance;

  final Dio _dio = Dio();

  sendQuery({required String query}) async {
    try {
      var response = await _dio.post(
          'https://cardamom-care-agent.onrender.com/ask',
          data: {"query": query});
      return response.data['response_text'];
    } catch (e) {
      throw Exception('Looks like something went wrong!');
    }
  }
}
