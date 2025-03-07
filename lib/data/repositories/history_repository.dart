import 'dart:developer';

import 'package:agranom_ai/common/app/injcetion_container.dart';
import 'package:agranom_ai/data/repositories/custom_dio_client.dart';
import 'package:dio/dio.dart';
import 'package:agranom_ai/data/models/get_history_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  final dioClient = getIt<DioClient>();
  final SharedPreferences _prefs = getIt<SharedPreferences>();


  Future<GetHistoryDto> getHistory() async {
    try {
      final token = _prefs.getString('token');
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await dioClient.dio.get(
        'https://api.agronomai.birnima.uz/api/predict',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

        log("Status code ........"+response.statusCode.toString());
      if (response.statusCode == 200) {
        return GetHistoryDto.fromJson(response.data);
      } else {
        throw Exception('Failed to load history');
      }
    } catch (e) {
      throw Exception('Error fetching history: $e');
    }
  }
}
