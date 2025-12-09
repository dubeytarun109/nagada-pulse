import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/models/sync_request.dart';
import '../core/models/sync_response.dart';

abstract class SyncTransport {
  Future<SyncResponse> sync(SyncRequest request);
}

/// An exception thrown when a sync operation fails at the transport level.
class SyncTransportException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  SyncTransportException(this.message, {this.statusCode, this.error});

  @override
  String toString() =>
      'SyncTransportException: $message (Status: $statusCode, Error: $error)';
}

/// Implements the Nagada sync protocol over HTTP.
class HttpSyncTransport implements SyncTransport {
  final Uri _serverUrl;
  final http.Client _client;

  HttpSyncTransport({required String serverUrl, http.Client? client})
      : _serverUrl = Uri.parse(serverUrl),
        _client = client ?? http.Client();

  /// Sends a [SyncRequest] to the server and returns a [SyncResponse].
  @override
  Future<SyncResponse> sync(SyncRequest request) async {
    http.Response response;
    try {
      response = await _client.post(
        _serverUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
    } catch (e) {
      throw SyncTransportException('Failed to connect to server', error: e);
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return SyncResponse(ackedClientEventIds: [], newServerEvents: []);
      }
      try {
        return SyncResponse.fromJson(json.decode(response.body));
      } catch (e) {
        throw SyncTransportException('Failed to decode server response', error: e, statusCode: response.statusCode);
      }
    } else {
      throw SyncTransportException('Failed to sync with server',
          statusCode: response.statusCode, error: response.body);
    }
  }
}
