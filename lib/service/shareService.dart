import 'package:share_plus/share_plus.dart';
import 'package:yande/service/cacheService.dart';

class ShareService {
  static Future<void> shareImage(String url) async {
    final imageFile = await CacheService.getFile(url);
    await Share.shareXFiles(<XFile>[XFile(imageFile.path)]);
  }
}