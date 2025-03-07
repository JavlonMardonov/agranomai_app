import 'dart:convert';
import 'dart:developer';

import 'package:agranom_ai/common/app/injcetion_container.dart';
import 'package:agranom_ai/common/constant/network_constant.dart';
import 'package:agranom_ai/data/repositories/custom_dio_client.dart';
import 'package:dio/dio.dart';

class ChatRepository {
  final dioClient = getIt<DioClient>();

  Future<String?> getChat({required String message, required String id}) async {
    try {
      log("Sending message: $message for ID: $id");
      final response = await dioClient.dio.post(
        "'https://api.agronomai.birnima.uz/api/predict/67c831d836c19ff62e03da2a/message",
        data: jsonEncode({"message": message}),
        options: Options(
          extra: {"requiresToken": true},
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        final payload = response.data;
        log("Response received: $payload");
        return payload["data"]["message"];
      } else {
        log("Unexpected status code: ${response.statusCode}");
        throw Exception("Server returned status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      log("Response: ${e.response?.data}");
      if (e.response?.statusCode == 403) {
        throw Exception("Authentication failed. Please log in again.");
      }
      throw Exception("Error sending message: ${e.message}");
    } catch (e) {
      log("Unexpected error: $e");
      throw Exception("Failed to send message: $e");
    }
  }
}
