import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:agranom_ai/common/app/injcetion_container.dart';
import 'package:agranom_ai/common/constant/network_constant.dart';
import 'package:agranom_ai/data/models/get_predict_dto.dart';
import 'package:agranom_ai/data/repositories/custom_dio_client.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class HomeRepo {
  Future<String?> getImageUrl({required File imageFile});
  Future<GetPredictDto?> getPredict({required String imagePath});
}

class HomeRepoImpl implements HomeRepo {
  final dioClient = getIt<DioClient>();
  Uint8List? image;

  void _imageToByte(File imageFile) {
    image = base64Decode(imageFile.path);
  }

  @override
  Future<String?> getImageUrl({required File imageFile, String? folder}) async {
    try {
      String fileName = imageFile.path.split('/').last;
      var fileExt = fileName.split('.').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType("image", fileExt),
        ),
      });

      // ✅ So‘rov jo‘natish
      final response = await dioClient.dio.post(
        NetworkConstants.uploadUrl,
        data: formData,
        queryParameters:
            folder != null ? {"folder": folder} : {}, // Folder ixtiyoriy
        options: Options(
          extra: {"requiresToken": true},
          headers: {
            "Authorization": "Bearer ${NetworkConstants.token}", // Token
          },
        ),
      );

      // ✅ Response tekshirish
      if (response.statusCode == 201) {
        final payload = response.data["data"]["url"];
        log("Uploaded URL: $payload");
        return payload;
      } else {
        throw Exception("Server returned status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      log("Dio Error Type: ${e.type}");
      log("Dio Error Response: ${e.response?.data}");
      throw Exception("Error happened while uploading file: ${e.message}");
    } catch (e) {
      log("Unexpected Error: $e");
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<GetPredictDto?> getPredict({required String imagePath}) async {
    try {
      final response = await dioClient.dio.post(
        NetworkConstants.predictUrl,
        data: {"image_path": "/uploads/default/6f49ffa2-82cb-44d5-8b03-d269f3b9ec0d.jpg"},
        options: Options(
          extra: {"requiresToken": true},
          headers: {
            "Authorization": "Bearer ${NetworkConstants.token}", // Token
          },
        ),
      );

      // ✅ Response tekshirish
      if (response.statusCode == 201) {
        final payload = response.data;
        log("Data fetching...: $payload");
        return GetPredictDto.fromJson(payload);
      } else {
        throw Exception("Server returned status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      log("Dio Error Type: ${e.type}");
      log("Dio Error Response: ${e.response?.data}");
      throw Exception("Error happened while predict: ${e.message}");
    } catch (e) {
      log("Error fetchin data: $e");
      throw Exception("Unexpected error: $e");
    }
  }
}
