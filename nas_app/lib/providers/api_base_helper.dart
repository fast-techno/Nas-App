import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:nas_app/providers/api_exception.dart';


class ApiBaseHelper {
  final String _baseUrl = "http://mudeer.nas.works/api/";

  Future<dynamic> get(String url, {required Map<String, String> headers}) async {
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      print(_baseUrl + url);
      final response = await http.get(Uri.parse(_baseUrl + url), headers: headers);
      responseJson = response;
      responseJson = json.decode(response.body.toString());
    } catch (err) {
      print(err);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, {headers}) async {
    print('Api Post, url $_baseUrl$url');

    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          body: body, headers: headers);
      responseJson = response;
      responseJson = json.decode(response.body.toString());
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print('Api Post, url $body');

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body, {required Map<String, String> headers}) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body , headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 404:
    case 209:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      var responseJson = json.decode(response.body.toString());
      String message = responseJson.toString();
      throw message;
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
