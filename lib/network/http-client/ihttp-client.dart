import 'dart:io';

import 'dart:typed_data';

abstract class IHttpClient {
  Future<Map<String, dynamic>> get(String path, [String query]);
  Future<String> getRawResponse(String path, [String query]);
  Future<Uint8List> getBytesResponse(String path, [String query]);
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data);
  Future<String> postRawResponse(String path, Map<String, dynamic> data);
  Future<bool> upload(String path, File file);
  Future<Map<String, dynamic>> delete(String path);
  Future<String> deleteRawResponse(String path);
}
