import 'dart:io';
import 'package:path/path.dart';

class FileUtils {
  static Future<Directory> getDirAndCreate(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static Future<List<MyDirectoryStat>> getAllDirectoryChildren(
      Directory dir) async {
    final list = <MyDirectoryStat>[];
    final dirChildren = await dir.list().toList();
    for (final entity in dirChildren) {
      final stat = await entity.stat();
      if (stat.type == FileSystemEntityType.directory) {
        list.add(MyDirectoryStat(
          directory: Directory(entity.path),
          name: basename(entity.path),
          path: entity.path,
        ));
      }
    }

    list.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    return list;
  }
}

class MyDirectoryStat {
  final Directory directory;
  final String name;
  final String path;

  MyDirectoryStat({
    required this.directory,
    required this.name,
    required this.path,
  });
}