// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['count'] as num?)?.toInt(),
      (json['type'] as num?)?.toInt(),
      json['ambiguous'] as bool?,
    )
      ..nickName = json['nick_name'] as String?
      ..order = (json['order'] as num?)?.toInt()
      ..collectStatus =
          $enumDecodeNullable(_$TagCollectStatusEnumMap, json['collect_status'])
      ..dataSourceName = json['dataSourceName'] as String?;

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nick_name': instance.nickName,
      'count': instance.count,
      'order': instance.order,
      'type': instance.type,
      'ambiguous': instance.ambiguous,
      'collect_status': _$TagCollectStatusEnumMap[instance.collectStatus],
      'dataSourceName': instance.dataSourceName,
    };

const _$TagCollectStatusEnumMap = {
  TagCollectStatus.none: 0,
  TagCollectStatus.collected: 1,
  TagCollectStatus.block: 2,
};
