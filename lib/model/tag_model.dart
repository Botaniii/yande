import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nick_name')
  String? nickName;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'ambiguous')
  bool? ambiguous;

  @JsonKey(name: 'collect_status')
  TagCollectStatus? collectStatus;

  String? dataSourceName;

  TagModel(this.id, this.name, this.count, this.type, this.ambiguous);

  factory TagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  /// 由 yande 图片的 tags 字符串（空格分隔）切出的单个 tag 名构造。
  factory TagModel.fromTagString(String name) =>
      TagModel(null, name, null, null, null);

  bool isCollect() => collectStatus == TagCollectStatus.collected;
}

enum TagCollectStatus {
  @JsonValue(0)
  none,
  @JsonValue(1)
  collected,
  @JsonValue(2)
  block,
}

const List<String?> TagType = ['普通', '画师', '会社', '角色', null];