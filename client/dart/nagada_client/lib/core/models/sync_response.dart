import 'package:json_annotation/json_annotation.dart';
import 'server_event.dart';

part 'sync_response.g.dart';

/// Data Transfer Object for a successful sync response from the server.
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SyncResponse {
  /// List of client event IDs that the server has successfully processed.
  final List<String> ackedClientEventIds;

  /// List of new events from the server that the client needs to apply.
  final List<ServerEvent> newServerEvents;

  SyncResponse({
    required this.ackedClientEventIds,
    required this.newServerEvents,
  });

  /// Creates a new `SyncResponse` from a JSON map.
  factory SyncResponse.fromJson(Map<String, dynamic> json) =>
      _$SyncResponseFromJson(json);

  /// Converts this `SyncResponse` to a JSON map.
  Map<String, dynamic> toJson() => _$SyncResponseToJson(this);
}