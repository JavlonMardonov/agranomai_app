class NetworkConstants {
  static const baseUrl = "https://api.agronomai.birnima.uz";

  static const uploadUrl = "https://api.agronomai.birnima.uz/api/upload";
  static const predictUrl = "https://api.agronomai.birnima.uz/api/predict";

  static const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdjMDJiMTE5ZjA2NTY3NjM0MDhkNTgwIiwiaWF0IjoxNzQwNjQ3MTg1fQ.heIM_-sLnnJx7Q3oY_TXksD5KjoiUiaKRrGl3eebQ3w";
}



  // @override
  // Future<CardModel?> getCards() async {
  //   final String? token =
  //       getIt<SharedPreferences>().getString(PrefsKeys.tokenKey);
  //   try {
  //     final response = await dioClient.dio.get(NetworkConstants.cardUrl,
  //         options: Options(headers: {"Authorization": "Bearer $token"}));

  //     if (response.statusCode == 200) {
  //       final payload = response.data;
  //       return CardModel.fromJson(payload);
  //     }
  //   } catch (e) {
  //     throw ServerException(
  //       errorMessage: "Error happened while fetching cards",
  //       statusCode: 500,
  //     );
  //   }
  //   return null;
  // }