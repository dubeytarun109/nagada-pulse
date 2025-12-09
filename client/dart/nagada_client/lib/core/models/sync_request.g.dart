// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncRequest _$SyncRequestFromJson(Map<String, dynamic> json) => SyncRequest(
  deviceId: json['deviceId'] as String,
  lastKnownServerEventId: (json['lastKnownServerEventId'] as num).toInt(),
  pendingEvents: (json['pendingEvents'] as List<dynamic>)
      .map((e) => ClientEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SyncRequestToJson(SyncRequest instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'lastKnownServerEventId': instance.lastKnownServerEventId,
      'pendingEvents': instance.pendingEvents.map((e) => e.toJson()).toList(),
    };
