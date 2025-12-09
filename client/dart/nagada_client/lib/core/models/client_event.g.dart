// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientEvent _$ClientEventFromJson(Map<String, dynamic> json) => ClientEvent(
  clientEventId: json['clientEventId'] as String,
  type: json['type'] as String,
  payload: json['payload'] as Map<String, dynamic>,
  timestamp: (json['timestamp'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClientEventToJson(ClientEvent instance) =>
    <String, dynamic>{
      'clientEventId': instance.clientEventId,
      'type': instance.type,
      'payload': instance.payload,
      'timestamp': instance.timestamp,
    };
