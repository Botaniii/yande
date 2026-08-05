import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// 通过 DoH（DNS over HTTPS）解析域名，绕开被污染的本地 DNS。
/// 优先走阿里公共 DNS（223.5.5.5，国内直连），失败时回退系统解析。
class DohResolver {
  static const String _dohUrl = 'https://223.5.5.5/resolve?type=A&name=';

  /// 解析 [host] 的 IPv4 地址；失败返回 null。
  static Future<String?> resolve(String host) async {
    if (host.isEmpty) return null;
    try {
      final client = HttpClient()
        ..connectionTimeout = const Duration(seconds: 5)
        ..badCertificateCallback = (cert, h, port) => h == '223.5.5.5';
      final req = await client
          .getUrl(Uri.parse('$_dohUrl$host'))
          .timeout(const Duration(seconds: 8));
      req.headers.set('Accept', 'application/dns-json');
      final res = await req.close().timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final body = await res.transform(utf8.decoder).join();
        final data = jsonDecode(body) as Map<String, dynamic>;
        final answers = data['Answer'] as List? ?? const [];
        for (final a in answers) {
          final map = a as Map<String, dynamic>;
          if (map['type'] == 1 && map['data'] is String) {
            final ip = map['data'] as String;
            if (ip.isNotEmpty && ip != '0.0.0.0') {
              return ip;
            }
          }
        }
      }
      client.close(force: true);
    } catch (_) {
      // 忽略，回退系统 DNS。
    }
    return null;
  }

  /// 供 [HttpClient.connectionFactory] 使用：
  /// 先 DoH 解析真实 IP，失败回退系统 DNS，再直连。
  static Future<ConnectionTask<Socket>> connectionFactory(
    Uri url,
    String? proxyHost,
    int? proxyPort,
  ) async {
    var ip = await resolve(url.host);
    if (ip == null) {
      try {
        final addrs = await InternetAddress.lookup(url.host);
        if (addrs.isNotEmpty) {
          ip = addrs.first.address;
        }
      } catch (_) {
        // 保持 null。
      }
    }
    final host = ip ?? url.host;
    final port = url.hasPort
        ? url.port
        : (url.scheme == 'https' ? 443 : 80);
    final socketFuture = Socket.connect(
      host,
      port,
      timeout: const Duration(seconds: 10),
    );
    return ConnectionTask.fromSocket(socketFuture, () {
      socketFuture.then((s) => s.destroy());
    });
  }
}