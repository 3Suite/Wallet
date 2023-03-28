import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient implements IHttpClient {
  final String schema;
  final String domain;
  final String path;

  HttpClient({
    @required this.schema,
    @required this.domain,
    @required this.path,
  });

  Future<String> getRawResponse(String path, [String query]) async {
    try {
      String url = _buildUri(path, query);
      print("GET: $url");

      var headers = await _getHeaders();
      var response = await http.get(url, headers: headers);

      print("GET: $url -> ${response.statusCode}");
      //print("GET: $url -> ${response.body}");

      if (response.statusCode >= 400) {
        return Future.error(response.body);
      }

      return response.body;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Uint8List> getBytesResponse(String path, [String query]) async {
    try {
      String url = _buildUri(path, query);
      print("GET: $url");

      var headers = await _getHeaders();
      var response = await http.get(url, headers: headers);

      print("GET: $url -> ${response.statusCode}");

      if (response.statusCode >= 400) {
        return Future.error(response.body);
      }

      return response.bodyBytes;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> get(String path, [String query]) async {
    try {
      String body = await getRawResponse(path, query);
      return json.decode(body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> postRawResponse(String path, Map<String, dynamic> data) async {
    try {
      var response;

      String url = _buildUri(path);
      print("POST: $url");
      if (data == null) {
        response = await http.post(url, headers: await _getHeaders());
      } else {
        var body = json.encode(data);
        response = await http.post(
          url,
          body: body,
          headers: await _getHeaders(),
        );
      }

      print("POST: $url -> ${response.statusCode}");
      //print("POST: $url -> ${response.body}");

      if (response.statusCode >= 400) {
        return Future.error(response.body);
      }

      return response.body;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      String body = await postRawResponse(path, data);
      return json.decode(body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> deleteRawResponse(String path) async {
    try {
      var response;

      String url = _buildUri(path);
      print("DELETE: $url");
      response = await http.delete(url, headers: await _getHeaders());

      print("DELETE: $url -> ${response.statusCode}");
      //print("DELETE: $url -> ${response.body}");

      if (response.statusCode >= 400) {
        return Future.error(response.body);
      }

      return response.body;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> delete(String path) async {
    try {
      String body = await deleteRawResponse(path);
      return json.decode(body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> upload(String path, File file) async {
    var headers = await _getHeaders();
    var url = _buildUri(path);
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(headers);
    var f = await http.MultipartFile.fromPath(
      "file",
      file.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(f);
    var response = await request.send();
    String body = await response.stream.bytesToString();

    // File is too large
    if (body.contains("<html>")) {
      return Future.error("Please contact support");
    }
    var answer;
    try {
      answer = json.decode(body);
    } catch (error) {
      return Future.error(error);
    }
    return answer;
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = Map();
    if (Platform.isAndroid) {
      headers["X-Device"] = "Android";
    } else {
      headers["X-Device"] = "iOS";
    }
    headers["Accept"] = "application/json";
    headers["Accept-Charset"] = "utf-8";
    headers["Accept-Encoding"] = "deflate, gzip";
    headers["Content-Type"] = "application/json; charset=utf-8";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString("accessToken");
    var confirmToken = prefs.getString("confirmToken");
    if (accessToken != null) {
      headers["Authorization"] = "Bearer $accessToken";
    } else if (confirmToken != null) {
      headers["Registration-Token"] = confirmToken;
    }
    return headers;
  }

  String _buildUri(String additionalPath, [String query]) {
    var segments = additionalPath.split("/").where((element) => element.isNotEmpty).toList();
    segments.insert(0, path);
    var uri = Uri(
      scheme: schema,
      host: domain,
      pathSegments: segments,
      query: query,
    );
    return uri.toString();
  }
}
