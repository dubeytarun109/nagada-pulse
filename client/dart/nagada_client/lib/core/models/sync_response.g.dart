// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncResponse _$SyncResponseFromJson(Map<String, dynamic> json) => SyncResponse(
  ackedClientEventIds: (json['acked_client_event_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  newServerEvents: (json['new_server_events'] as List<dynamic>)
      .map((e) => ServerEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SyncResponseToJson(
  SyncResponse instance,
) => <String, dynamic>{
  'acked_client_event_ids': instance.ackedClientEventIds,
  'new_server_events': instance.newServerEvents.map((e) => e.toJson()).toList(),
};
