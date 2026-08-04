import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/tag_model.dart';

void main() {
  late DaoDataSource source;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    source = DaoDataSource(
      injectedDatabaseFactory: databaseFactoryFfi,
      injectedDatabasePath: inMemoryDatabasePath,
    );
  });

  test('block tag roundtrip', () async {
    final tag =
        TagModel.fromTagString('loli')..collectStatus = TagCollectStatus.block;
    await source.saveTag(tag);
    final blocked = await source.getAllBlockTag();
    expect(blocked.single.name, 'loli');
    expect(blocked.single.collectStatus, TagCollectStatus.block);
  });

  test('collected tag appears in shortcuts', () async {
    final tag = TagModel.fromTagString('solo')
      ..collectStatus = TagCollectStatus.collected;
    await source.saveTag(tag);
    final shortcuts = await source.getAllCollectTag();
    expect(shortcuts.single.name, 'solo');
  });
}