import 'package:yande/model/tag_model.dart';
import 'package:yande/service/tagService.dart';

class TagStore {
  static List<TagModel> shortCutList = <TagModel>[];
  static List<TagModel> blockedTag = <TagModel>[];

  static Future<void> init() async {
    shortCutList = <TagModel>[];
    blockedTag = <TagModel>[];
    await _getShortcutList();
    await _getBlockTagList();
  }

  static Future<void> _getShortcutList() async {
    shortCutList = await TagService.getAllCollectTag();
  }

  static Future<void> _getBlockTagList() async {
    blockedTag = await TagService.getAllBlockTag();
  }

  static Future<void> collectTag(TagModel tag) async {
    tag.collectStatus = TagCollectStatus.collected;
    await TagService.setCollectStatus(tag);
    removeTagFromBlockList(tag);
    shortCutList.add(tag);
  }

  static Future<void> unCollectTag(TagModel tag) async {
    tag.collectStatus = TagCollectStatus.none;
    await TagService.setCollectStatus(tag);
    removeTagFromShortCutList(tag);
  }

  static Future<void> block(TagModel tag) async {
    tag.collectStatus = TagCollectStatus.block;
    await TagService.setCollectStatus(tag);
    blockedTag.add(tag);
  }

  static Future<void> unblock(TagModel tag) async {
    tag.collectStatus = TagCollectStatus.none;
    await TagService.setCollectStatus(tag);
    removeTagFromShortCutList(tag);
    blockedTag.removeWhere((item) => item.name == tag.name);
  }

  static void removeTagFromBlockList(TagModel tag) {
    blockedTag.removeWhere((item) => item.name == tag.name);
  }

  static void removeTagFromShortCutList(TagModel tag) {
    shortCutList.removeWhere((item) => item.name == tag.name);
  }

  static bool isBlockedByName(String? name) {
    if (name == null) return false;
    for (final tag in blockedTag) {
      if (name.contains(tag.name ?? '')) {
        return true;
      }
    }
    return false;
  }

  static bool isBlocked(TagModel tagModel) {
    return isBlockedByName(tagModel.name);
  }

  static bool isCollectByName(String name) {
    for (final tag in shortCutList) {
      if (tag.name == name) {
        return true;
      }
    }
    return false;
  }

  static bool isCollect(TagModel tagModel) {
    for (final tag in shortCutList) {
      if (tag.name == tagModel.name) {
        return true;
      }
    }
    return false;
  }
}