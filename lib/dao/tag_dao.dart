import 'package:sqflite/sqflite.dart';
import 'package:yande/model/tag_model.dart';
import 'init_dao.dart';

class TagDao {
  final DaoDataSource source;

  TagDao(this.source);

  Future<bool> isTagExistByName(String name, [Database? database]) async {
    final db = database ?? await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Tag,
        where: '${TagTableColumn.name} = ?',
        whereArgs: <Object?>[name],
        limit: 1,
      );
      return list.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveTag(TagModel tag) async {
    final db = await source.getDatabase();
    try {
      final exists = await isTagExistByName(tag.name ?? '', db);
      if (!exists) {
        await db.insert(MyDateBaseValue.Tag, tag.toJson());
      } else {
        await db.update(
          MyDateBaseValue.Tag,
          <String, Object?>{
            TagTableColumn.collectStatus: tag.collectStatus?.index,
          },
          where: '${TagTableColumn.name} = ?',
          whereArgs: <Object?>[tag.name],
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCollectStatus(TagModel tag, [Database? database]) async {
    final db = database ?? await source.getDatabase();
    try {
      await db.update(
        MyDateBaseValue.Tag,
        <String, Object?>{
          TagTableColumn.collectStatus: tag.collectStatus?.index,
        },
        where: '${TagTableColumn.name} = ?',
        whereArgs: <Object?>[tag.name],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TagModel>> getAllCollectTag() async {
    final db = await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Tag,
        where: '${TagTableColumn.collectStatus} = ?',
        whereArgs: <Object?>[TagCollectStatus.collected.index],
      );
      return list
          .map((val) => TagModel.fromJson(Map<String, dynamic>.from(val)))
          .toList();
    } catch (e) {
      return <TagModel>[];
    }
  }

  Future<List<TagModel>> getAllBlockTag() async {
    final db = await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Tag,
        where: '${TagTableColumn.collectStatus} = ?',
        whereArgs: <Object?>[TagCollectStatus.block.index],
      );
      return list
          .map((val) => TagModel.fromJson(Map<String, dynamic>.from(val)))
          .toList();
    } catch (e) {
      return <TagModel>[];
    }
  }
}