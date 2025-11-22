// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:naibrly/utils/api/local_storage.dart';
//
//
// class BaseClient {
//   static var noInternetMessage = "Please check your connection!";
//
//   static getRequest({required String api, params}) async {
//     debugPrint("\nYou hit: $api");
//     debugPrint("Request Params: $params");
//
//     /// get x storage
//     final StorageService _storageService = Get.put(StorageService());
//     String? accessToken = _storageService.read<String>('accessToken');
//
//     var headers = {
//       'Content-type': 'application/json',
//       "Authorization": "Bearer $accessToken"
//     };
//     debugPrint("statusCode: id: ");
//
//     http.Response response = await http.get(
//       Uri.parse(api).replace(queryParameters: params),
//       headers: headers,
//     );
//     return response;
//   }
//
//   static Future<http.Response> postRequest({required String api, required dynamic body}) async {
//     debugPrint('\nYou hit: $api');
//     debugPrint('Request Body: ${jsonEncode(body)}');
//
//     /// Get the access token from local storage
//     final StorageService _storageService = Get.put(StorageService());
//     String? accessToken = _storageService.read<String>('accessToken');
//
//     var headers = {
//       "Authorization": "Bearer $accessToken",
//       'Content-Type': 'application/json'
//     };
//
//     // Ensure the body is properly encoded as JSON
//     var jsonBody = jsonEncode(body);
//
//     try {
//       http.Response response = await http.post(
//         Uri.parse(api),
//         body: jsonBody,
//         headers: headers,
//       );
//
//       // Return the response
//       return response;
//     } on SocketException {
//       throw noInternetMessage; // Handle internet connection issues
//     } catch (e) {
//       throw 'Error: $e'; // Catch other errors
//     }
//   }
//
//
//   static deleteRequest({required String api, body}) async {
//     debugPrint('\nYou hit: $api');
//     debugPrint('Request Body: ${jsonEncode(body)}');
//
//     /// getx storage
//     final StorageService _storageService = Get.put(StorageService());
//     String? accessToken = _storageService.read<String>('accessToken');
//
//     var headers = {
//       'Accept': 'application/json',
//       "Authorization": "Bearer $accessToken"
//     };
//
//     http.Response response =
//     await http.delete(Uri.parse(api), body: body, headers: headers);
//     return response;
//   }
//
//   // Add PATCH method here
//   static patchRequest(
//       {required String api, required Map<String, dynamic> body}) async {
//     debugPrint('\nYou hit: $api');
//     debugPrint('Request Body: ${jsonEncode(body)}');
//
//     /// getx storage
//     final StorageService _storageService = Get.put(StorageService());
//     String? accessToken = _storageService.read<String>('accessToken');
//
//     var headers = {
//       'Content-type': 'application/json',
//       "Authorization": "Bearer $accessToken"
//     };
//
//     try {
//       http.Response response = await http.patch(
//         Uri.parse(api),
//         body: jsonEncode(body),
//         headers: headers,
//       );
//       return response;
//     } on SocketException {
//       throw noInternetMessage;
//     } catch (e) {
//       throw e.toString();
//     }
//   }
//
//   static multipartAddRequest({
//     required String api,
//     required Map<String, String> body,
//     required String fileKeyName,
//     required String filePath,
//   }) async {
//     print("\nYou hit: $api");
//     print("Request body: $body");
//
//     var headers = {'Accept': 'application/json', "id": ""};
//
//     http.MultipartRequest request;
//     if (filePath.isEmpty || filePath == '') {
//       request = http.MultipartRequest('POST', Uri.parse(api))
//         ..fields.addAll(body)
//         ..headers.addAll(headers);
//     } else {
//       request = http.MultipartRequest('POST', Uri.parse(api))
//         ..fields.addAll(body)
//         ..headers.addAll(headers)
//         ..files.add(await http.MultipartFile.fromPath(fileKeyName, filePath));
//     }
//
//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//
//     return response;
//   }
//
//   static handleResponse(http.Response response) async {
//     try {
//       if (response.statusCode >= 200 && response.statusCode <= 210) {
//         debugPrint('SuccessCode: ${response.statusCode}');
//         debugPrint('SuccessResponse: ${response.body}');
//
//         if (response.body.isNotEmpty) {
//           return json.decode(response.body);
//         } else {
//           return response.body;
//         }
//       } else if (response.statusCode == 500) {
//         debugPrint("statusCode: 500");
//         throw "Server Error";
//       } else {
//         debugPrint('ErrorCode: ${response.statusCode}');
//         debugPrint('ErrorResponse: ${response.body}');
//
//         String msg = "Something went wrong";
//         if (response.body.isNotEmpty) {
//           var data = jsonDecode(response.body)['errors'];
//           if (data == null) {
//             msg = jsonDecode(response.body)['message'] ?? msg;
//           } else if (data is String) {
//             msg = data;
//           } else if (data is Map) {
//             msg = data['email'][0];
//           }
//         }
//
//         throw msg;
//       }
//     } on SocketException catch (_) {
//       throw noInternetMessage;
//     } on FormatException catch (_) {
//       throw "Bad response format";
//     } catch (e) {
//       throw e.toString();
//     }
//   }
// }