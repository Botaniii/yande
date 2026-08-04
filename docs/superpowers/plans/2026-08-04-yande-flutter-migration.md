# yande Flutter 鐜颁唬鍖栬縼绉诲疄鏂借鍒?
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 鎶?2019 骞寸殑 yande.re 绗笁鏂?Flutter 瀹㈡埛绔紙Dart 2 / Flutter beta锛寁1 Android embedding锛夎縼绉诲埌褰撳墠 Flutter stable锛屼娇 `flutter analyze` 闆堕棶棰樸€佸崟鍏?缁勪欢娴嬭瘯閫氳繃锛屽苟鑳戒骇鍑?Android debug APK銆?
**Architecture:** 淇濈暀鐜版湁鍒嗗眰锛坔ttp 鏁版嵁婧?/ dao 鏁版嵁搴?/ service 涓氬姟 / view 椤甸潰 / widget 缁勪欢锛夛紝閫愪釜鏂囦欢鍋氱┖瀹夊叏涓庢柊鐗?API 杩佺Щ锛涙ā鍨嬬敤 `@JsonValue` 娉ㄨВ璁╂灇涓惧簭鍒楀寲姝ｇ‘锛孌AO 鍏ㄩ儴鏀逛负鍙傛暟鍖?SQL 骞朵慨姝ｈ〃缁撴瀯锛汚ndroid 骞冲彴鐩綍鐢?`flutter create` 閲嶆柊鐢熸垚浠ュ垏鎹㈠埌 v2 embedding锛岃嚜瀹氫箟骞挎挱鎻掍欢鏀瑰啓鎴?v2 API锛涙渶鍚庣敤 GitHub Actions 鍋氫簯绔獙璇併€?
**Tech Stack:** Flutter stable锛圖art 3锛夈€乨io ^5銆乧ached_network_image ^3銆乻qflite ^2銆乸hoto_view ^0.15銆乸ath_provider ^2銆乻hared_preferences ^2銆乻hare_plus銆乸ackage_info_plus銆乽rl_launcher ^6銆乫lutter_cache_manager ^3銆乯son_serializable ^6銆乥uild_runner ^2銆乻qflite_common_ffi锛堟祴璇曪級銆?
## Global Constraints

- 璇█锛歚lib/` 鍏ㄩ儴鍚敤绌哄畨鍏紙Dart 3锛夛紝`flutter analyze` 蹇呴』 0 閿欒 0 璀﹀憡銆?- 鍖呭悕/applicationId 淇濇寔涓嶅彉锛歚xyz.xiaopo.yande`锛汚pp 鏄剧ず鍚嶄繚鎸?`yande`銆?- 鐜版湁 UI 鏂囨锛圲TF-8 涓枃锛変竴寰嬩笉鏀瑰啓锛屼笉鍋氱炕璇戞垨娑﹁壊銆?- Android minSdk 21锛宑ompileSdk/targetSdk 浣跨敤褰撳墠 Flutter 妯℃澘榛樿鍊笺€?- 鍒犻櫎鎵€鏈夌‖缂栫爜绛惧悕鍑嵁锛涙湰闃舵鍙瀯寤?debug APK锛宺elease 绛惧悕鏀逛负鐜鍙橀噺鏂规锛堣 Task 8锛夈€?- 涓嬭浇鐩綍榛樿鏀逛负搴旂敤鏂囨。鐩綍锛坄getApplicationDocumentsDirectory()/yandeImage`锛夛紝鍥犳绉婚櫎 `WRITE_EXTERNAL_STORAGE` 鏉冮檺涓?Java 杩愯鏃舵潈闄愪唬鐮併€?- 鏁版嵁搴?schema 鍗囧埌 v3锛宍onUpgrade` 閲囩敤 drop + recreate锛堝崌绾т細涓㈠け鏈湴鏀惰棌/涓嬭浇璁板綍锛屼綔涓哄紑鍙戝熀绾垮彲鎺ュ彈锛岄渶鍦ㄦ墽琛屾椂鍛婄煡鐢ㄦ埛锛夈€?- 鑼冨洿锛氫粎 Android 骞冲彴銆俰OS 鍦?Windows 涓婃棤娉曟瀯寤猴紝涓旈」鐩己 Podfile锛屽垪涓鸿寖鍥村锛堝悗缁彲鍦?macOS CI 澶勭悊锛夈€?- 姣忓畬鎴愪竴涓?Task 鍦?`codex/yande-flutter-migration` 鍒嗘敮鎻愪氦涓€娆°€?- `origin` 鏄敤鎴疯嚜宸辩殑 fork锛圔otaniii/yande锛夛紝鍒嗘敮灏辩华鍚庡彲鑷敱鎺ㄩ€佸埌璇?fork锛涘闇€鍚屾涓婃父鍙﹁纭銆?
---

## 鍏堣锛氬叧浜?鏄惁蹇呴』鍦ㄦ湰鏈鸿 Flutter"鐨勫喅瀹?
缁撹锛?*蹇呴』鏈変竴濂楄兘璺戠殑 Flutter 宸ュ叿閾炬墠鑳藉畬鎴愯縼绉婚獙璇侊紝浣嗕笉绛変簬浼犵粺"瀹夎"**銆備笁涓€夐」锛屾帹鑽?A锛?
- **A锛堟帹鑽愶級渚挎惡鐗?SDK**锛氫笅杞?Flutter stable 鐨?zip 瑙ｅ帇鍒?`C:\Users\admin\Desktop\zcode-program\yande-remake\flutter`锛屼笉鍐欐敞鍐岃〃銆佷笉鍔犲叏灞€ PATH銆佷笉闇€瑕佺鐞嗗憳鏉冮檺锛涗娇鐢ㄦ椂涓存椂璁?PATH 鎴栫洿鎺ヨ皟 `.\flutter\bin\flutter.bat`銆傚悓鏃堕渶瑕?Android SDK 鍛戒护琛屽伐鍏凤紙涔熻鍦ㄧ敤鎴风洰褰曪紝闈炵郴缁熺骇锛夈€傚嵏杞?= 鍒犵洰褰曘€?- **B Docker**锛氭湰鏈哄綋鍓嶆病鏈?Docker锛岃 Docker 鏈韩姣旇 Flutter 鏇撮噸锛屼笉鎺ㄨ崘銆?- **C 瀹屽叏涓嶅湪鏈満瑁?*锛氬彧鍐欎唬鐮侊紝鐢?Task 9 鐨?GitHub Actions 鍦ㄤ簯绔窇 `pub get / analyze / test / build apk`銆傚彲琛屼絾杩唬鎱紙姣忔楠岃瘉瑕?push锛夛紝涓旀湰鏈烘棤娉曡窇 `flutter analyze` 蹇€熷弽棣堛€?
鍙﹀璇存槑锛氭湰鏈虹幇鍦ㄦ湁 Java 21銆佹病鏈?adb/Android SDK銆傚彧璺?`analyze/test` 涓嶉渶瑕?Android SDK锛涜浜у嚭 APK锛圱ask 8 鐨勯棬绂侊級鎵嶉渶瑕佽 Android commandline-tools锛堢害 0.5鈥? GB锛岃鍒扮敤鎴风洰褰曪級銆?
## 琛屼负鍙樻洿娓呭崟锛堟墽琛屾椂闇€鍚戠敤鎴风‘璁わ級

1. 涓嬭浇鐩綍浠?澶栭儴瀛樺偍 DCIM"鏀逛负"搴旂敤鏂囨。鐩綍"锛岀郴缁熺浉鍐岀湅涓嶅埌涓嬭浇鏂囦欢锛涘ソ澶勬槸褰诲簳涓嶇敤瀛樺偍鏉冮檺锛孉ndroid 10+ 鍒嗗尯瀛樺偍涓嬩篃鑳藉啓銆?2. 鍗囩骇鍒版暟鎹簱 v3 鏃舵竻绌烘湰鍦版敹钘?涓嬭浇璁板綍锛坉rop + recreate锛夈€?3. 鍚姩鍥炬爣鍦?Task 8 浼氳 `flutter create` 鎹㈡垚榛樿 Flutter 鍥炬爣锛堝師鍥炬爣鍙悗缁墜宸ユ仮澶嶏紝鑼冨洿澶栵級銆?4. 绉婚櫎"蹇界暐姝ょ増鏈?鏇存柊妫€鏌ョ殑闅愭€?bug锛堣 Task 4锛夛紝鍚姩鏃舵鏌ユ洿鏂板け璐ユ敼涓洪潤榛樸€?
## 鏂囦欢缁撴瀯锛堟湰璁″垝灏嗘柊寤?淇敼鐨勬枃浠讹級

| 璺緞 | 璐ｄ换 | 浠诲姟 |
|---|---|---|
| `pubspec.yaml` | 渚濊禆涓庣増鏈熀绾?| Task 3 |
| `analysis_options.yaml` | lint 閰嶇疆 | Task 2 |
| `lib/main.dart` | 鍚姩寮曞锛坅sync init锛?| Task 4 |
| `lib/appliction.dart` | 鍗曚緥 + 鏁版嵁婧愭睜锛堢┖瀹夊叏锛?| Task 4 |
| `lib/model/image_model.dart`銆乣tag_model.dart`銆乣github_model.dart`锛?`.g.dart`锛?| 绌哄畨鍏ㄦā鍨嬨€乣@JsonValue` 鏋氫妇 | Task 3 |
| `lib/service/settingService.dart`銆乣downloadService.dart`銆乣cacheService.dart`銆乣shareService.dart`銆乣updateService.dart`銆乣imageServive.dart`銆乣tagService.dart` | 鏂扮増渚濊禆 API + 绌哄畨鍏?| Task 4 |
| `lib/store/tagStore.dart` | 绌哄畨鍏?+ 绌哄垪琛ㄥ厹搴?| Task 4 |
| `lib/http/yande/imageListApi.dart`銆乣tagApi.dart`銆乣YandeHttpDataSource.dart` | dio 5 + 琛ュ叏绌哄疄鐜?| Task 5 |
| `lib/dao/init_dao.dart`銆乣image_dao.dart`銆乣tag_dao.dart` | schema v3銆佸弬鏁板寲 SQL銆佸彲娉ㄥ叆 DB | Task 6 |
| `lib/widget/`銆乣lib/view/` 鍏ㄩ儴 UI 鏂囦欢 | cached_network_image 3 / Material 3 缁勪欢 / ScaffoldMessenger / 绌哄畨鍏?| Task 7 |
| `lib/widget/rich_text.dart` | 鍒犻櫎锛堟湭浣跨敤锛?| Task 7 |
| `android/` | v2 embedding銆丟radle 8銆佹棤绛惧悕瀵嗛挜 | Task 8 |
| `test/` | 妯″瀷/鏈嶅姟/DAO/缁勪欢娴嬭瘯锛屽垹闄ゆā鏉胯鏁板櫒娴嬭瘯 | Task 3鈥? |
| `.github/workflows/flutter-ci.yml` | 浜戠楠岃瘉 | Task 9 |
| `README.md` | 鏇存柊鏋勫缓璇存槑 | Task 9 |

---

### Task 1: 宸ュ叿閾惧噯澶囷紙渚挎惡鐗?Flutter + Android SDK锛?
**Files:** 鏃犱粨搴撴枃浠跺彉鏇达紙浠呮湰鏈虹幆澧冿級銆?
**Interfaces:**
- Produces: 鍙敤鐨?`flutter` 鍛戒护锛坄C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat`锛変笌 Android SDK锛坄C:\Users\admin\Android`锛夈€?
- [ ] **Step 1: 涓嬭浇骞惰В鍘?Flutter stable锛坺ip 鎴?git clone 浜岄€変竴锛?*

鏂瑰紡涓€锛坺ip锛岄渶缃戠粶锛涚害 1 GB锛夛細

```powershell
$flutterZip = "$env:TEMP\flutter_windows_stable.zip"
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json" -OutFile "$env:TEMP\flutter_releases.json"
# 浠?json 閲屽彇 stable 鏈€鏂扮増鏈殑 archive 瀛楁锛岀劧鍚庯細
# Invoke-WebRequest -Uri "<archive_url>" -OutFile $flutterZip
Expand-Archive -Path $flutterZip -DestinationPath "C:\Users\admin\Desktop\zcode-program"
```

鏂瑰紡浜岋紙git clone锛屾帹鑽愶紝渚夸簬 `flutter upgrade`锛夛細

```powershell
git clone -b stable https://github.com/flutter/flutter.git "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter"
```

楠岃瘉锛?
```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" --version
```

Expected: 鎵撳嵃 `Flutter x.y.z 鈥?channel stable 鈥?... Dart 3.x.x`銆?
- [ ] **Step 2: 瀹夎 Android commandline-tools 骞跺畨瑁?SDK 缁勪欢**

浠?<https://developer.android.com/studio#command-line-tools-only> 涓嬭浇 `commandlinetools-win-*_latest.zip`锛岀劧鍚庯細

```powershell
New-Item -ItemType Directory -Force -Path "C:\Users\admin\Android\cmdline-tools" | Out-Null
Expand-Archive -Path "$env:TEMP\commandlinetools-win-*_latest.zip" -DestinationPath "C:\Users\admin\Android\cmdline-tools"
Move-Item "C:\Users\admin\Android\cmdline-tools\cmdline-tools" "C:\Users\admin\Android\cmdline-tools\latest"
$sdkmanager = "C:\Users\admin\Android\cmdline-tools\latest\bin\sdkmanager.bat"
& $sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
& $sdkmanager --licenses   # 鍏ㄩ儴杈撳叆 y
```

- [ ] **Step 3: 鎶?SDK 璺緞鍛婅瘔 Flutter 骞堕獙璇?*

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" config --android-sdk "C:\Users\admin\Android"
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" doctor
```

Expected: `doctor` 杈撳嚭涓?`Flutter` 涓?`Android toolchain` 涓ら」鍧囦负 `[鈭歖`銆傦紙Java 21 宸叉弧瓒冲綋鍓?AGP/Gradle 瑕佹眰銆傦級

**璇存槑锛?* 涓婅堪涓嬭浇鍧囬渶瑕佺綉缁滐紝鎵ц鏃堕渶璇锋眰鐢ㄦ埛鎵瑰噯锛涜嫢鐢ㄦ埛閫夋嫨 Task 9 鐨勭函 CI 璺嚎锛屾湰浠诲姟鍙烦杩囷紝`flutter` 鐩稿叧鍛戒护鏀瑰湪 CI 涓繍琛屻€?
---

### Task 2: 浠撳簱鍩虹嚎锛堝垎鏀€佸畨鍏ㄦ竻鐞嗐€乴int 閰嶇疆銆佹彁浜ゆ柟妗堟枃妗ｏ級

**Files:**
- Modify: `android/app/build.gradle`
- Create: `analysis_options.yaml`
- Create: `docs/superpowers/plans/2026-08-04-yande-flutter-migration.md`锛堟湰鏂囦欢锛?
**Interfaces:** 鏃犲澶栨帴鍙ｃ€?
- [ ] **Step 1: 娣诲姞 git safe.directory 骞跺缓鍒嗘敮**

```powershell
git config --global --add safe.directory 'C:/Users/admin/Desktop/zcode-program/yande'
git switch -c codex/yande-flutter-migration
```

Expected: 鍒囨崲鍒版柊鍒嗘敮銆?
- [ ] **Step 2: 鍒犻櫎 `android/app/build.gradle` 涓殑纭紪鐮佺鍚嶅嚟鎹?*

鍒犻櫎鏁翠釜 `signingConfigs { ... }` 鍧楋紝骞舵妸涓や釜 `buildTypes` 閲岀殑 `signingConfig signingConfigs.release` 琛屽垹鎺夛紝鏀逛负锛?
```gradle
buildTypes {
    release {
        // 绛惧悕鏀圭敤鐜鍙橀噺锛岃 Task 8锛涙湰鍦板紑鍙戝彧鏋勫缓 debug銆?    }
    debug {
    }
}
```

**瀹夊叏璇存槑锛?* 瀵嗙爜涓?keyAlias 宸茶繘鍏?git 鍘嗗彶锛屽垹闄ゅ綋鍓嶆枃浠跺彧鏄鎹燂紱鏃?keystore 鑻ヤ粛鍦ㄤ娇鐢紝搴斿湪 Task 8 涔嬪悗閲嶆柊鐢熸垚骞惰疆鎹紙鍘嗗彶閲嶅啓涓嶅湪鏈鍒掕寖鍥达級銆?
- [ ] **Step 3: 鎻愪氦鍩虹嚎**

```powershell
git add android/app/build.gradle docs/superpowers/plans/2026-08-04-yande-flutter-migration.md
git commit -m "chore: remove hardcoded signing credentials, add migration plan"
```

Expected: 鎻愪氦鎴愬姛锛宍git status` 骞插噣銆?
- [ ] **Step 4: 鍒涘缓 `analysis_options.yaml`锛堝湪 Task 3 瑁呭畬 flutter_lints 鍚庣敓鏁堬級**

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: false
    prefer_const_literals_to_create_immutables: false
    use_key_in_widget_constructors: false
```

璇存槑锛氳繖涓夋潯鏄櫔闊崇骇鏍峰紡瑙勫垯锛岃縼绉婚樁娈靛厛鍏抽棴锛涙纭€х浉鍏?lint 淇濇寔榛樿銆傛鏂囦欢闅?Task 3 涓€璧锋彁浜ゃ€?
---

### Task 3: 渚濊禆鍗囩骇 + 妯″瀷绌哄畨鍏?+ 浠ｇ爜鐢熸垚

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/model/tag_model.dart`
- Modify: `lib/model/image_model.dart`
- Modify: `lib/model/github_model.dart`
- Regenerate: `lib/model/*.g.dart`
- Create: `test/models/tag_model_test.dart`
- Create: `test/models/image_model_test.dart`

**Interfaces:**
- Consumes: 鏃犮€?- Produces:
  - `TagModel`锛堝叏瀛楁鍙┖锛沗collectStatus` 鏋氫妇鍚?`block`锛屽簭鍒楀寲涓?0/1/2锛?  - `TagModel.fromTagString(String name)` 宸ュ巶
  - `ImageModel`锛堝叏瀛楁鍙┖锛沗collectStatus`/`downloadStatus` 榛樿 null锛屽簭鍒楀寲涓?int锛?  - `GithubReleaseModel` 鍏ㄥ瓧娈靛彲绌?
- [ ] **Step 1: 鐢?pub 瑙ｆ瀽鏈€鏂颁緷璧栧苟璁剧疆 SDK 绾︽潫**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" pub add dio cached_network_image sqflite share_plus photo_view path_provider shared_preferences path package_info_plus url_launcher flutter_cache_manager cupertino_icons
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" pub add --dev build_runner json_serializable flutter_lints sqflite_common_ffi
```

鐒跺悗鎶?`pubspec.yaml` 涓?`environment` 鏀逛负锛?
```yaml
environment:
  sdk: '>=3.0.0 <4.0.0'
```

骞舵妸 `version: 0.2.5+5` 鏀逛负 `version: 1.0.0+1`銆傛渶缁?`pubspec.yaml` 搴旂被浼硷細

```yaml
name: yande
description: A third-party yande.re client.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  dio: ^5.0.0
  cached_network_image: ^3.0.0
  sqflite: ^2.0.0
  share_plus: ^7.0.0
  photo_view: ^0.15.0
  path_provider: ^2.0.0
  shared_preferences: ^2.0.0
  path: ^1.8.0
  package_info_plus: ^4.0.0
  url_launcher: ^6.0.0
  flutter_cache_manager: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.0.0
  json_serializable: ^6.0.0
  sqflite_common_ffi: ^2.0.0

flutter:
  uses-material-design: true
```

Expected: `flutter pub get` 鎴愬姛锛屾棤鐗堟湰鍐茬獊銆?
- [ ] **Step 2: 閲嶅啓 `lib/model/tag_model.dart`锛堢┖瀹夊叏 + `@JsonValue` 鏋氫妇 + fromTagString锛?*

```dart
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

  /// 鐢?yande 鍥剧墖鐨?tags 瀛楃涓诧紙绌烘牸鍒嗛殧锛夊垏鍑虹殑鍗曚釜 tag 鍚嶆瀯閫犮€?  factory TagModel.fromTagString(String name) =>
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

const List<String?> TagType = ['鏅€?, '鐢诲笀', '浼氱ぞ', '瑙掕壊', null];
```

- [ ] **Step 3: 閲嶅啓 `lib/model/image_model.dart`锛堢┖瀹夊叏 + 榛樿鐘舵€佹敼 null锛?*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'tag_model.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tags')
  String? tags;

  List<TagModel>? tagTagModelList;

  int? pages;

  @JsonKey(name: 'collect_status')
  ImageCollectStatus? collectStatus;

  @JsonKey(name: 'download_status')
  ImageDownloadStatus? downloadStatus;

  @JsonKey(name: 'download_path')
  String? downloadPath;

  @JsonKey(name: 'created_at')
  int? createdAt;

  @JsonKey(name: 'updated_at')
  int? updatedAt;

  @JsonKey(name: 'creator_id')
  int? creatorId;

  @JsonKey(name: 'author')
  String? author;

  @JsonKey(name: 'change')
  int? change;

  @JsonKey(name: 'source')
  String? source;

  @JsonKey(name: 'score')
  int? score;

  @JsonKey(name: 'md5')
  String? md5;

  @JsonKey(name: 'file_size')
  int? fileSize;

  @JsonKey(name: 'file_ext')
  String? fileExt;

  @JsonKey(name: 'file_url')
  String? fileUrl;

  @JsonKey(name: 'is_shown_in_index')
  bool? isShownInIndex;

  @JsonKey(name: 'preview_url')
  String? previewUrl;

  @JsonKey(name: 'preview_width')
  int? previewWidth;

  @JsonKey(name: 'preview_height')
  int? previewHeight;

  @JsonKey(name: 'actual_preview_width')
  int? actualPreviewWidth;

  @JsonKey(name: 'actual_preview_height')
  int? actualPreviewHeight;

  @JsonKey(name: 'sample_url')
  String? sampleUrl;

  @JsonKey(name: 'sample_width')
  int? sampleWidth;

  @JsonKey(name: 'sample_height')
  int? sampleHeight;

  @JsonKey(name: 'sample_file_size')
  int? sampleFileSize;

  @JsonKey(name: 'jpeg_url')
  String? jpegUrl;

  @JsonKey(name: 'jpeg_width')
  int? jpegWidth;

  @JsonKey(name: 'jpeg_height')
  int? jpegHeight;

  @JsonKey(name: 'jpeg_file_size')
  int? jpegFileSize;

  @JsonKey(name: 'rating')
  String? rating;

  @JsonKey(name: 'is_rating_locked')
  bool? isRatingLocked;

  @JsonKey(name: 'has_children')
  bool? hasChildren;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'is_pending')
  bool? isPending;

  @JsonKey(name: 'width')
  int? width;

  @JsonKey(name: 'height')
  int? height;

  @JsonKey(name: 'is_held')
  bool? isHeld;

  @JsonKey(name: 'frames_pending_string')
  String? framesPendingString;

  @JsonKey(name: 'frames_pending')
  List<dynamic>? framesPending;

  @JsonKey(name: 'frames_string')
  String? framesString;

  @JsonKey(name: 'frames')
  List<dynamic>? frames;

  @JsonKey(name: 'is_note_locked')
  bool? isNoteLocked;

  @JsonKey(name: 'last_noted_at')
  int? lastNotedAt;

  @JsonKey(name: 'last_commented_at')
  int? lastCommentedAt;

  String? dataSourceName;

  ImageModel(
    this.id,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
    this.author,
    this.change,
    this.source,
    this.score,
    this.md5,
    this.fileSize,
    this.fileExt,
    this.fileUrl,
    this.isShownInIndex,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.actualPreviewWidth,
    this.actualPreviewHeight,
    this.sampleUrl,
    this.sampleWidth,
    this.sampleHeight,
    this.sampleFileSize,
    this.jpegUrl,
    this.jpegWidth,
    this.jpegHeight,
    this.jpegFileSize,
    this.rating,
    this.isRatingLocked,
    this.hasChildren,
    this.status,
    this.isPending,
    this.width,
    this.height,
    this.isHeld,
    this.framesPendingString,
    this.framesPending,
    this.framesString,
    this.frames,
    this.isNoteLocked,
    this.lastNotedAt,
    this.lastCommentedAt,
  );

  factory ImageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ImageModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  bool isCollect() => collectStatus == ImageCollectStatus.star;

  bool isDownload() =>
      downloadStatus == ImageDownloadStatus.success &&
      downloadPath != null &&
      downloadPath!.isNotEmpty;

  void setStatusByImage(ImageModel model) {
    collectStatus = model.collectStatus;
    downloadStatus = model.downloadStatus;
    if (model.downloadStatus == ImageDownloadStatus.success) {
      downloadPath = model.downloadPath;
    } else if (model.downloadStatus != null) {
      downloadStatus = ImageDownloadStatus.error;
    }
  }
}

enum ImageDownloadStatus {
  @JsonValue(0)
  none,
  @JsonValue(1)
  pending,
  @JsonValue(2)
  success,
  @JsonValue(3)
  error,
}

enum ImageCollectStatus {
  @JsonValue(0)
  star,
  @JsonValue(1)
  unStar,
}
```

- [ ] **Step 4: 閲嶅啓 `lib/model/github_model.dart`锛堝叏閮ㄥ瓧娈靛彲绌猴紝缁撴瀯涓嶅彉锛?*

```dart
class GithubReleaseModel {
  String? url;
  String? assetsUrl;
  String? uploadUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  String? tagName;
  String? targetCommitish;
  String? name;
  bool? draft;
  GithubAuthor? author;
  bool? prerelease;
  String? createdAt;
  String? publishedAt;
  List<GithubAssets>? assets;
  String? tarballUrl;
  String? zipballUrl;
  String? body;

  GithubReleaseModel({
    this.url,
    this.assetsUrl,
    this.uploadUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.tagName,
    this.targetCommitish,
    this.name,
    this.draft,
    this.author,
    this.prerelease,
    this.createdAt,
    this.publishedAt,
    this.assets,
    this.tarballUrl,
    this.zipballUrl,
    this.body,
  });

  GithubReleaseModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    assetsUrl = json['assets_url'];
    uploadUrl = json['upload_url'];
    htmlUrl = json['html_url'];
    id = json['id'];
    nodeId = json['node_id'];
    tagName = json['tag_name'];
    targetCommitish = json['target_commitish'];
    name = json['name'];
    draft = json['draft'];
    author = json['author'] != null
        ? GithubAuthor.fromJson(json['author'])
        : null;
    prerelease = json['prerelease'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
    if (json['assets'] != null) {
      assets = <GithubAssets>[];
      (json['assets'] as List).forEach((v) {
        assets!.add(GithubAssets.fromJson(v));
      });
    }
    tarballUrl = json['tarball_url'];
    zipballUrl = json['zipball_url'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['assets_url'] = assetsUrl;
    data['upload_url'] = uploadUrl;
    data['html_url'] = htmlUrl;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['tag_name'] = tagName;
    data['target_commitish'] = targetCommitish;
    data['name'] = name;
    data['draft'] = draft;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['prerelease'] = prerelease;
    data['created_at'] = createdAt;
    data['published_at'] = publishedAt;
    if (assets != null) {
      data['assets'] = assets!.map((v) => v.toJson()).toList();
    }
    data['tarball_url'] = tarballUrl;
    data['zipball_url'] = zipballUrl;
    data['body'] = body;
    return data;
  }
}

class GithubAuthor {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  GithubAuthor({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  GithubAuthor.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    return data;
  }
}

class GithubAssets {
  String? url;
  int? id;
  String? nodeId;
  String? name;
  dynamic label;
  Uploader? uploader;
  String? contentType;
  String? state;
  int? size;
  int? downloadCount;
  String? createdAt;
  String? updatedAt;
  String? browserDownloadUrl;

  GithubAssets({
    this.url,
    this.id,
    this.nodeId,
    this.name,
    this.label,
    this.uploader,
    this.contentType,
    this.state,
    this.size,
    this.downloadCount,
    this.createdAt,
    this.updatedAt,
    this.browserDownloadUrl,
  });

  GithubAssets.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    label = json['label'];
    uploader = json['uploader'] != null
        ? Uploader.fromJson(json['uploader'])
        : null;
    contentType = json['content_type'];
    state = json['state'];
    size = json['size'];
    downloadCount = json['download_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    browserDownloadUrl = json['browser_download_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['label'] = label;
    if (uploader != null) {
      data['uploader'] = uploader!.toJson();
    }
    data['content_type'] = contentType;
    data['state'] = state;
    data['size'] = size;
    data['download_count'] = downloadCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['browser_download_url'] = browserDownloadUrl;
    return data;
  }
}

class Uploader {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  Uploader({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  Uploader.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    return data;
  }
}
```

- [ ] **Step 5: 閲嶆柊鐢熸垚 `.g.dart` 骞堕獙璇佹灇涓炬槧灏?*

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\dart.bat" run build_runner build --delete-conflicting-outputs
```

Expected: 鐢熸垚鎴愬姛銆傛鏌?`lib/model/tag_model.g.dart` 涓細

```dart
const _$TagCollectStatusEnumMap = <TagCollectStatus, dynamic>{
  TagCollectStatus.none: 0,
  TagCollectStatus.collected: 1,
  TagCollectStatus.block: 2
};
```

鑻ョ己 `block: 2`锛岃鏄?`@JsonValue(2)` 娌＄敓鏁堬紝鍏堜慨娉ㄨВ鍐嶉噸璺戙€?
- [ ] **Step 6: 鍐欐ā鍨嬫祴璇曪紙鍏堝啓鍚庤窇锛?*

`test/models/tag_model_test.dart`锛?
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/tag_model.dart';

void main() {
  group('TagModel', () {
    test('collect_status roundtrip includes block', () {
      final tag = TagModel(1, 'solo', null, null, null)
        ..collectStatus = TagCollectStatus.block;
      final json = tag.toJson();
      expect(json['collect_status'], 2);
      final decoded = TagModel.fromJson(json);
      expect(decoded.collectStatus, TagCollectStatus.block);
    });

    test('fromTagString builds model with name', () {
      final tag = TagModel.fromTagString('long_hair');
      expect(tag.name, 'long_hair');
      expect(tag.collectStatus, isNull);
    });
  });
}
```

`test/models/image_model_test.dart`锛?
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';

void main() {
  group('ImageModel', () {
    test('fromJson/toJson roundtrip statuses as ints', () {
      final image = ImageModel.fromJson({
        'id': 42,
        'tags': 'a b',
        'rating': 's',
        'collect_status': 1,
        'download_status': 2,
        'download_path': '/tmp/42.jpg',
      });
      expect(image.id, 42);
      expect(image.collectStatus, ImageCollectStatus.unStar);
      expect(image.downloadStatus, ImageDownloadStatus.success);

      final json = image.toJson();
      expect(json['collect_status'], 1);
      expect(json['download_status'], 2);
      expect(json['download_path'], '/tmp/42.jpg');
    });

    test('missing statuses default to null', () {
      final image = ImageModel.fromJson({'id': 1});
      expect(image.collectStatus, isNull);
      expect(image.downloadStatus, isNull);
      expect(image.isCollect(), isFalse);
    });

    test('setStatusByImage merges collected status', () {
      final remote = ImageModel.fromJson({'id': 1, 'rating': 'q'});
      final local = ImageModel.fromJson({
        'id': 1,
        'collect_status': 0,
        'download_status': 2,
        'download_path': '/data/1.jpg',
      });
      remote.setStatusByImage(local);
      expect(remote.collectStatus, ImageCollectStatus.star);
      expect(remote.downloadStatus, ImageDownloadStatus.success);
      expect(remote.downloadPath, '/data/1.jpg');
    });
  });
}
```

- [ ] **Step 7: 璺戞祴璇曚笌鍒嗘瀽**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test test/models
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
```

Expected: 妯″瀷娴嬭瘯鍏ㄧ豢銆俙analyze` 鍙兘浠嶆姤鍏跺畠鏂囦欢閿欒锛堝悗缁换鍔″鐞嗭級锛屼絾 `lib/model/` 涓嶅簲鎶ラ敊銆?
- [ ] **Step 8: 鎻愪氦**

```powershell
git add pubspec.yaml pubspec.lock analysis_options.yaml lib/model test/models
git commit -m "feat: migrate models to null safety with JsonValue enums"
```

---

### Task 4: 搴旂敤寮曞涓?Service 灞傝縼绉?
**Files:**
- Modify: `lib/main.dart`
- Modify: `lib/appliction.dart`
- Modify: `lib/service/settingService.dart`
- Modify: `lib/service/downloadService.dart`
- Modify: `lib/service/cacheService.dart`
- Modify: `lib/service/shareService.dart`
- Modify: `lib/service/updateService.dart`
- Modify: `lib/service/imageServive.dart`
- Modify: `lib/service/tagService.dart`
- Modify: `lib/store/tagStore.dart`
- Create: `test/services/image_service_test.dart`

**Interfaces:**
- Consumes: `TagModel`銆乣ImageModel`锛圱ask 3锛夈€?- Produces:
  - `Future<void> Application.init()`锛氬敮涓€鍒濆鍖栧叆鍙ｏ紙await 鍚?`getInstance()` 鍙敤锛?  - `bool applyFilterRank(ImageModel image, String? filterRank)`锛坄@visibleForTesting`锛宼rue = 搴旇杩囨护鎺夛級
  - `SettingService.getSetting` 淇濊瘉杩斿洖闈炵┖ value锛堢己鐪佸洖閫€榛樿鍊硷級

- [ ] **Step 1: 閲嶅啓 `lib/appliction.dart`锛坅sync 鍗曚緥 + 鏁版嵁婧愭睜绌哄畨鍏級**

```dart
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/settingService.dart';

class Application {
  static Application? _instance;

  static Application getInstance() {
    final instance = _instance;
    if (instance == null) {
      throw StateError(
          'Application.init() must be awaited before getInstance()');
    }
    return instance;
  }

  static Future<void> init() async {
    if (_instance != null) return;
    final app = Application._();
    _instance = app;
    await app._bootstrap();
  }

  final Dio _dio;
  String? filterRank;
  late final _AppDataSourcePool dataPool;

  Application._() {
    _dio = Dio();
    dataPool = _AppDataSourcePool();
    dataPool.registryDataSource(YandeImageHttpDataSource(_dio));
    dataPool.registryDataSource(DaoDataSource());
  }

  Future<void> _bootstrap() async {
    await SettingService.initSetting();
    await getFilterRank();
  }

  Future<void> getFilterRank() async {
    final filterRankItem =
        await SettingService.getSetting(SETTING_TYPE.FILTER_RANK);
    filterRank = filterRankItem.value;
  }

  Future<void> setFilterRank(SettingItem item) async {
    await SettingService.saveSetting(item);
    filterRank = item.value;
  }
}

abstract class AppDataSource {
  String get sourceName;

  Future<List<ImageModel>> fetchImageByPage(int page, int limit);
  Future<ImageModel?> fetchImageById(int id);
  Future<List<ImageModel>> fetchImageByTag(String tag, int page, int limit);
}

abstract class AppHttpDataSource extends AppDataSource {
  Dio http;
  Future<List<TagModel>> searchTag(String words);
}

abstract class AppDaoDataSource extends AppDataSource {
  Future<Database> getDatabase();
  Future<bool> isImageExistById(int id);
  Future<void> updateDownloadImageStatus(ImageModel image);
  Future<void> collectImage(ImageModel image);
  Future<List<ImageModel>> getAllCollectedImage();
  Future<void> saveTag(TagModel tag);
  Future<List<TagModel>> getAllCollectTag();
  Future<List<TagModel>> getAllBlockTag();
}

class _AppDataSourcePool {
  final Map<String, AppDataSource> _pool = <String, AppDataSource>{};
  AppDataSource? _activeSource;

  AppDataSource getSource([String? name]) {
    if (name == null) {
      final active = _activeSource;
      if (active == null) {
        throw StateError('No active data source');
      }
      return active;
    }
    final source = _pool[name];
    if (source == null) {
      throw StateError('No data source named "$name"');
    }
    return source;
  }

  List<String> getAllHttpSourceNameList() {
    final keys = _pool.keys.toList();
    keys.removeWhere((value) => value == DaoDataSource.name);
    return keys;
  }

  void switchHttpSource(String name) {
    final source = _pool[name];
    if (source == null) {
      throw StateError('No data source named "$name"');
    }
    _activeSource = source;
  }

  void removeHttpSource(String name) {
    _pool.remove(name);
  }

  String getActiveSourceName() {
    return _activeSource!.sourceName;
  }

  void registryDataSource(AppDataSource source) {
    _pool[source.sourceName] = source;
    _activeSource ??= source;
  }
}
```

- [ ] **Step 2: 閲嶅啓 `lib/main.dart`锛坅sync 鍚姩锛屾妸 TagStore.init 绉诲嚭鏋勯€犲櫒锛?*

```dart
import 'package:flutter/material.dart';
import 'package:yande/appliction.dart';
import 'package:yande/route/route.dart';
import 'package:yande/store/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Application.init();
  await TagStore.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yande',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: _buildRoutes(),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      allViewRoutes,
      key: (dynamic demo) => '${demo.routeName}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }
}
```

- [ ] **Step 3: 閲嶅啓 `lib/service/settingService.dart`锛坧ath_provider 2 + await + 闈炵┖鍥為€€锛?*

```dart
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  static final List<SettingItem<String>> settingList = [
    SettingItem(
      name: SETTING_TYPE.IMAGE_DOWNLOAD_PATH,
      value: '',
    ),
    SettingItem(
      name: SETTING_TYPE.FILTER_RANK,
      value: FILTER_RANK.NORMAL,
    ),
  ];

  static Future<void> initSetting([bool? force]) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('initSetting') != true || force == true) {
      for (final item in settingList) {
        if (item.name == SETTING_TYPE.IMAGE_DOWNLOAD_PATH) {
          final appDocDir = await getApplicationDocumentsDirectory();
          final yandeImageDir =
              Directory('${appDocDir.path}/yandeImage');
          if (!await yandeImageDir.exists()) {
            await yandeImageDir.create(recursive: true);
          }
          item.value = yandeImageDir.path;
          await saveSetting(item);
        } else if (item.name == SETTING_TYPE.FILTER_RANK) {
          await saveSetting(item);
        }
      }
      await prefs.setBool('initSetting', true);
    } else {
      await getAllSetting();
    }
  }

  static Future<void> saveSetting(SettingItem settingItem) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(settingItem.name, settingItem.value);
  }

  static Future<SettingItem<String>> getSetting(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(name);
    String? defaultValue;
    for (final item in settingList) {
      if (item.name == name) {
        defaultValue = item.value;
        break;
      }
    }
    return SettingItem<String>(
        name: name, value: value ?? defaultValue ?? '');
  }

  static Future<List<SettingItem<String>>> getAllSetting() async {
    final prefs = await SharedPreferences.getInstance();
    for (final item in settingList) {
      item.value = prefs.getString(item.name) ?? item.value;
    }
    return settingList;
  }
}

// ignore: camel_case_types
class SETTING_TYPE {
  static const String IMAGE_DOWNLOAD_PATH = '鍥剧墖涓嬭浇璺緞';
  static const String FILTER_RANK = '杩囨护绛夌骇';
}

// ignore: camel_case_types
class FILTER_RANK {
  static const String NORMAL = 's';
  static const String NOT_RESTRICTED = 'q';
  static const String RESTRICTED = 'e';
}

class SettingItem<T> {
  String name;
  T value;

  SettingItem({required this.name, required this.value});
}
```

- [ ] **Step 4: 閲嶅啓 `lib/service/downloadService.dart`锛堢‘淇濈洰褰曞瓨鍦?+ 绌哄畨鍏級**

```dart
import 'package:dio/dio.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/settingService.dart';
import 'package:yande/utils/utils.dart';

class DownloadService {
  static Future<void> downloadImage(
    ImageModel image, {
    ProgressCallback? onProcess,
  }) async {
    final source = Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;

    image.downloadStatus = ImageDownloadStatus.pending;
    await source.updateDownloadImageStatus(image);

    try {
      if (image.fileUrl == null || image.fileExt == null) {
        throw StateError('image has no fileUrl/fileExt');
      }
      final filePath = await _getDownloadPath(image);
      await _doDownload(Dio(), image, filePath, onProcess);

      image.downloadStatus = ImageDownloadStatus.success;
      image.downloadPath = filePath;
      await source.updateDownloadImageStatus(image);

      await ScanImagePlugins.broadcast(filePath);
    } catch (e) {
      image.downloadStatus = ImageDownloadStatus.error;
      await source.updateDownloadImageStatus(image);
    }
  }

  static Future<void> _doDownload(
    Dio dio,
    ImageModel image,
    String filePath,
    ProgressCallback? onProcess,
  ) {
    return dio.download(
      image.fileUrl!,
      filePath,
      onReceiveProgress: onProcess,
    );
  }

  static Future<String> _getDownloadPath(ImageModel image) async {
    final dirPath = (await SettingService.getSetting(
      SETTING_TYPE.IMAGE_DOWNLOAD_PATH,
    ))
        .value;
    await FileUtils.getDirAndCreate(dirPath);
    return '$dirPath/${image.id}.${image.fileExt}';
  }
}
```

- [ ] **Step 5: 閲嶅啓 `lib/service/cacheService.dart` 涓?`lib/service/shareService.dart`**

```dart
// cacheService.dart
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static final DefaultCacheManager _cache = DefaultCacheManager();

  static Future<File> getFile(String url) => _cache.getSingleFile(url);
}
```

```dart
// shareService.dart
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:yande/service/cacheService.dart';

class ShareService {
  static Future<void> shareImage(String url) async {
    final imageFile = await CacheService.getFile(url);
    await Share.shareXFiles(<XFile>[XFile(imageFile.path)]);
  }
}
```

- [ ] **Step 6: 閲嶅啓 `lib/service/updateService.dart`锛坧ackage_info_plus + 淇 ignore 閫昏緫锛?*

```dart
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yande/http/all_api.dart';
import 'package:yande/model/github_model.dart';
import 'package:yande/service/settingService.dart';

typedef ShouldUpdateCallback = void Function(GithubReleaseModel);

class UpdateService {
  static Future<void> getVersion({
    ShouldUpdateCallback? shouldUpdate,
  }) async {
    final dio = Dio();
    final res = await dio.get<dynamic>(GithubApi.latestApi);
    final githubReleaseModel = GithubReleaseModel.fromJson(
      Map<String, dynamic>.from(res.data as Map),
    );
    final packageInfo = await PackageInfo.fromPlatform();
    final item = await SettingService.getSetting(UpdateValue.ignoreVersion);

    if (githubReleaseModel.tagName != item.value &&
        packageInfo.version != githubReleaseModel.tagName) {
      shouldUpdate?.call(githubReleaseModel);
    }
  }

  static Future<void> ignoreUpdateVersion(String version) async {
    await SettingService.saveSetting(
      SettingItem(name: UpdateValue.ignoreVersion, value: version),
    );
  }
}

class UpdateValue {
  static const String ignoreVersion = 'ignoreVersion';
}
```

- [ ] **Step 7: 淇?`lib/service/imageServive.dart`锛堟娊鍑哄彲娴嬭繃婊ゅ嚱鏁?+ 绌哄畨鍏級**

鎶?`_imageFilter` 鏀逛负椤跺眰鍙祴鍑芥暟锛屽苟璁?`collectImage`銆乣getAllCollectedImage` 绌哄畨鍏細

```dart
import 'package:flutter/foundation.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/settingService.dart';
import 'package:yande/store/store.dart';

class ImageService {
  static Future<List<ImageModel>> getIndexListByPage(
    int pages,
    int limit, {
    String? sourceName,
  }) async {
    final source = _getAppDataSource(sourceName);
    final list = await source.fetchImageByPage(pages, limit);
    if (list.isEmpty) {
      throw NoImageError();
    }
    list.removeWhere(_imageFilter);
    list.removeWhere((image) => TagStore.isBlockedByName(image.tags));
    return list;
  }

  static Future<List<ImageModel>> getImageByTag(
    String tags,
    int pages,
    int limit, {
    String? sourceName,
  }) async {
    final source = _getAppDataSource(sourceName);
    final list = await source.fetchImageByTag(tags, pages, limit);
    if (list.isEmpty) {
      throw NoImageError();
    }
    list.removeWhere(_imageFilter);
    list.removeWhere((image) => TagStore.isBlockedByName(image.tags));
    return list;
  }

  static Future<ImageModel> collectImage(ImageModel image) async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    image.collectStatus =
        (image.collectStatus == ImageCollectStatus.unStar ||
                image.collectStatus == null)
            ? ImageCollectStatus.star
            : ImageCollectStatus.unStar;
    await source.collectImage(image);
    return image;
  }

  static Future<List<ImageModel>> getAllCollectedImage(
    int page,
    int limit,
  ) async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    final imageList = await source.getAllCollectedImage();
    if (imageList.isNotEmpty) {
      for (final imageModel in imageList) {
        imageModel.pages = page;
        imageModel.tagTagModelList = imageModel.tags
            ?.split(' ')
            .map(TagModel.fromTagString)
            .toList();
      }
    }
    return imageList;
  }

  static bool _imageFilter(ImageModel image) =>
      applyFilterRank(image, Application.getInstance().filterRank);

  static AppDataSource _getAppDataSource(String? sourceName) {
    return Application.getInstance().dataPool.getSource(sourceName);
  }
}

/// true 琛ㄧず璇ュ浘鐗囧簲琚繃婊ゆ帀锛堜笌鏃?`_imageFilter` 璇箟涓€鑷达級銆?@visibleForTesting
bool applyFilterRank(ImageModel image, String? filterRank) {
  if (filterRank == FILTER_RANK.RESTRICTED) {
    return false;
  } else if (filterRank == FILTER_RANK.NOT_RESTRICTED) {
    return image.rating == FILTER_RANK.RESTRICTED;
  } else {
    return image.rating == FILTER_RANK.RESTRICTED ||
        image.rating == FILTER_RANK.NOT_RESTRICTED;
  }
}

class NoImageError extends Error {}
```

- [ ] **Step 8: 淇?`lib/service/tagService.dart` 涓?`lib/store/tagStore.dart`锛堢┖瀹夊叏 + 绌哄垪琛ㄥ厹搴曪級**

`tagService.dart` 涓昏鏀瑰姩锛堝叾浣欓€昏緫涓嶅彉锛夛細

```dart
static Future<List<TagModel>> getTagByNameOrderAESC(
  String name, {
  String? sourceName,
}) async {
  final source = _getAppDataSource(sourceName) as AppHttpDataSource;
  return source.searchTag(name);
}

static Future<void> saveTag(TagModel tag) async {
  final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
  await source.saveTag(tag);
}

static Future<List<TagModel>> getAllCollectTag() async {
  final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
  return source.getAllCollectTag();
}

static Future<List<TagModel>> getAllBlockTag() async {
  final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
  return source.getAllBlockTag();
}

static Future<void> setCollectStatus(TagModel tag) async {
  tag.collectStatus = TagCollectStatus.collected;
  await TagService.saveTag(tag);
}
```

`tagStore.dart` 鏀瑰姩锛?
```dart
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

static bool isBlockedByName(String? name) {
  if (name == null) return false;
  for (final tag in blockedTag) {
    if (name.contains(tag.name ?? '')) {
      return true;
    }
  }
  return false;
}
```

鍏朵綑鏂规硶锛坄collectTag`銆乣unCollectTag`銆乣block`銆乣unblock`銆乣isCollectByName` 绛夛級鍙仛绌哄畨鍏ㄥ皬鏀癸細`void` 鏀?`Future<void>` 鎴栧湪璋冪敤澶勫姞 `await` 鍗冲彲锛岄€昏緫涓嶅彉銆?
- [ ] **Step 9: 鍐欒繃婊ら€昏緫娴嬭瘯 `test/services/image_service_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/imageServive.dart';

void main() {
  group('applyFilterRank', () {
    ImageModel imageWith(String rating) =>
        ImageModel.fromJson({'id': 1, 'rating': rating});

    test('RESTRICTED filter keeps everything', () {
      expect(applyFilterRank(imageWith('e'), 'e'), isFalse);
      expect(applyFilterRank(imageWith('q'), 'e'), isFalse);
      expect(applyFilterRank(imageWith('s'), 'e'), isFalse);
    });

    test('NOT_RESTRICTED filters out e only', () {
      expect(applyFilterRank(imageWith('e'), 'q'), isTrue);
      expect(applyFilterRank(imageWith('q'), 'q'), isFalse);
      expect(applyFilterRank(imageWith('s'), 'q'), isFalse);
    });

    test('NORMAL filters out e and q', () {
      expect(applyFilterRank(imageWith('e'), 's'), isTrue);
      expect(applyFilterRank(imageWith('q'), 's'), isTrue);
      expect(applyFilterRank(imageWith('s'), 's'), isFalse);
    });
  });
}
```

- [ ] **Step 10: 璺戞祴璇曚笌鍒嗘瀽**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test test/models test/services
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
```

Expected: 妯″瀷 + service 娴嬭瘯鍏ㄧ豢锛沗analyze` 鍓╀綑閿欒搴斿彧闆嗕腑鍦?http/dao/view锛堝悗缁换鍔″鐞嗭級銆?
- [ ] **Step 11: 鎻愪氦**

```powershell
git add lib/main.dart lib/appliction.dart lib/service lib/store test/services
git commit -m "feat: async app bootstrap and service layer migration"
```

---

### Task 5: HTTP 灞傝縼绉伙紙dio 5 + 琛ュ叏绌哄疄鐜帮級

**Files:**
- Modify: `lib/http/yande/imageListApi.dart`
- Modify: `lib/http/yande/tagApi.dart`
- Modify: `lib/http/yande/YandeHttpDataSource.dart`
- Create: `test/http/tag_parsing_test.dart`

**Interfaces:**
- Consumes: `TagModel.fromTagString`锛圱ask 3锛夈€乣AppDataSource.fetchImageById` 杩斿洖 `Future<ImageModel?>`锛圱ask 4锛夈€?- Produces: `YandeImageListApi.fetchImageById(String id)` 鐪熷疄瀹炵幇锛涘垹闄?`TagApi.searchImageByTag` 绌烘柟娉曘€?
- [ ] **Step 1: 閲嶅啓 `lib/http/yande/imageListApi.dart`**

```dart
import 'package:dio/dio.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/constant/api.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';

class YandeImageListApi {
  final YandeImageHttpDataSource source;

  YandeImageListApi(this.source);

  AppDaoDataSource get _daoDataSource {
    return Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;
  }

  Future<ImageModel?> fetchImageById(String id) async {
    final url = '${YandeApi.post}?tags=id:$id&limit=1';
    final res = await source.http.get<List<dynamic>>(url);
    final list = convertMapToImageModel(res);
    return list.isEmpty ? null : list.first;
  }

  Future<List<ImageModel>> fetchImageByPage(int page, int limit) async {
    final url = '${YandeApi.post}?page=$page&limit=$limit';
    final res = await source.http.get<List<dynamic>>(url);
    return _decorate(res, page);
  }

  Future<List<ImageModel>> getIndexListByTags(
    String tags,
    int pages,
    int limit,
  ) async {
    final url = '${YandeApi.post}?tags=$tags&page=$pages&limit=$limit';
    final res = await source.http.get<List<dynamic>>(url);
    return _decorate(res, pages);
  }

  /// 鍚堝苟鏈湴鏀惰棌/涓嬭浇鐘舵€侊紝骞惰В鏋?tags 瀛楃涓层€?  Future<List<ImageModel>> _decorate(
      Response<List<dynamic>> res, int page) async {
    final list = convertMapToImageModel(res);
    final trueList = <ImageModel>[];
    for (final item in list) {
      if (item.tags != null) {
        item.tagTagModelList = convertTagStringToList(item.tags!);
      }
      final dto = await _daoDataSource.fetchImageById(item.id ?? -1);
      if (dto != null) {
        item.setStatusByImage(dto);
      }
      item.dataSourceName = source.sourceName;
      item.pages = page;
      trueList.add(item);
    }
    return trueList;
  }

  List<ImageModel> convertMapToImageModel(Response<List<dynamic>> res) {
    return res.data
        .map((item) =>
            ImageModel.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  List<TagModel> convertTagStringToList(String tags) {
    return tags.split(' ').map(TagModel.fromTagString).toList();
  }
}
```

- [ ] **Step 2: 淇?`lib/http/yande/tagApi.dart`锛堝垹闄ょ┖鏂规硶锛屽姞绌哄畨鍏級**

```dart
import 'package:dio/dio.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/constant/api.dart';
import 'package:yande/model/tag_model.dart';

class TagApi {
  final YandeImageHttpDataSource source;

  TagApi(this.source);

  Future<List<TagModel>> getTagByNameOrderAESC(String name) async {
    final dio = Dio();
    final url = '${YandeApi.tag}?limit=40&order=count&name=$name';
    final res = await dio.get<List<dynamic>>(url);
    return res.data
        .map((item) =>
            TagModel.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }
}
```

- [ ] **Step 3: 淇?`lib/http/yande/YandeHttpDataSource.dart`锛堣ˉ fetchImageById锛?*

```dart
@override
Future<ImageModel?> fetchImageById(int id) {
  return _imageListApi.fetchImageById('$id');
}
```

鍏朵綑鏂规硶绛惧悕鏀逛负 `Future<ImageModel?>` 鎴栦繚鎸?`Future<List<ImageModel>>` 涓嶅彉锛屽瓧娈?`http`/`sourceName` 淇濇寔闈炵┖銆?
- [ ] **Step 4: 鍐?tag 瑙ｆ瀽娴嬭瘯 `test/http/tag_parsing_test.dart`**

```dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/imageListApi.dart';
import 'package:yande/model/tag_model.dart';

void main() {
  group('convertTagStringToList', () {
    test('splits space separated tags', () {
      final api = YandeImageListApi(YandeImageHttpDataSource(Dio()));
      final tags = api.convertTagStringToList('solo long_hair blue_eyes');
      expect(tags.map((t) => t.name), ['solo', 'long_hair', 'blue_eyes']);
      expect(tags.every((t) => t is TagModel), isTrue);
    });
  });
}
```

- [ ] **Step 5: 璺戞祴璇曚笌鍒嗘瀽**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test test/http test/models test/services
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
```

Expected: 鍏ㄧ豢锛涘墿浣欓敊璇泦涓湪 dao/view銆?
- [ ] **Step 6: 鎻愪氦**

```powershell
git add lib/http test/http
git commit -m "feat: migrate http layer to dio 5 and fill missing implementations"
```

---

### Task 6: DAO 涓庢暟鎹簱杩佺Щ锛坰chema v3 + 鍙傛暟鍖?SQL + 鍙敞鍏?DB锛?
**Files:**
- Modify: `lib/dao/init_dao.dart`
- Modify: `lib/dao/image_dao.dart`
- Modify: `lib/dao/tag_dao.dart`
- Create: `test/dao/image_dao_test.dart`
- Create: `test/dao/tag_dao_test.dart`

**Interfaces:**
- Consumes: `Application`/`AppDaoDataSource` 鎺ュ彛锛圱ask 4锛夈€?- Produces:
  - `DaoDataSource({DatabaseFactory? databaseFactory, String? databasePath})`
  - `DaoDataSource.getAllBlockTag()` 濮旀墭鐪熷疄瀹炵幇
  - `ImageDao`/`TagDao` 鍏ㄩ儴杩斿洖绌洪泦鍚堣€岄潪 null

- [ ] **Step 1: 閲嶅啓 `lib/dao/init_dao.dart`锛坰chema v3銆佸彲娉ㄥ叆 factory/path銆乷nUpgrade锛?*

```dart
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/image_dao.dart';
import 'package:yande/dao/tag_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';

class MyDateBaseValue {
  static const Tag = 'tag';
  static const Image = 'image';
}

class ImageTableColumn {
  static const id = 'id';
  static const tags = 'tags';
  static const author = 'author';
  static const fileUrl = 'file_url';
  static const source = 'source';
  static const fileSize = 'file_size';
  static const fileExt = 'file_ext';
  static const previewUrl = 'preview_url';
  static const previewWidth = 'preview_width';
  static const previewHeight = 'preview_height';
  static const rating = 'rating';
  static const sampleUrl = 'sample_url';
  static const jpegUrl = 'jpeg_url';
  static const jpegWidth = 'jpeg_width';
  static const jpegHeight = 'jpeg_height';
  static const height = 'height';
  static const width = 'width';
  static const jpegFileSize = 'jpeg_file_size';
  static const collectStatus = 'collect_status';
  static const downloadStatus = 'download_status';
  static const downloadPath = 'download_path';
  static const dataSourceName = 'dataSourceName';
}

class TagTableColumn {
  static const id = 'id';
  static const name = 'name';
  static const nickName = 'nick_name';
  static const count = 'count';
  static const type = 'type';
  static const ambiguous = 'ambiguous';
  static const collectStatus = 'collect_status';
  static const dataSourceName = 'dataSourceName';
}

class DaoDataSource implements AppDaoDataSource {
  static String get name => 'dao';

  final DatabaseFactory? databaseFactory;
  final String? databasePath;

  DaoDataSource({this.databaseFactory, this.databasePath});

  @override
  String get sourceName => name;

  late final ImageDao _imageDao = ImageDao(this);
  late final TagDao _tagDao = TagDao(this);

  @override
  Future<Database> getDatabase() async {
    final factory = databaseFactory ?? sqflite.databaseFactory;
    final path = databasePath ?? '${await factory.getDatabasesPath()}/yande.db';
    return factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 3,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
      ),
    );
  }

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${MyDateBaseValue.Tag} ('
      'id INTEGER,'
      'name TEXT,'
      'nick_name TEXT,'
      'count INTEGER,'
      'type INTEGER,'
      'ambiguous INTEGER,'
      'dataSourceName TEXT,'
      'collect_status INTEGER'
      ')',
    );
    await db.execute(
      'CREATE TABLE ${MyDateBaseValue.Image} ('
      'id INTEGER PRIMARY KEY,'
      'tags TEXT,'
      'author TEXT,'
      'file_url TEXT,'
      'source TEXT,'
      'file_size INTEGER,'
      'file_ext TEXT,'
      'preview_url TEXT,'
      'preview_width INTEGER,'
      'preview_height INTEGER,'
      'rating TEXT,'
      'width INTEGER,'
      'height INTEGER,'
      'sample_url TEXT,'
      'jpeg_url TEXT,'
      'jpeg_width INTEGER,'
      'jpeg_height INTEGER,'
      'jpeg_file_size INTEGER,'
      'dataSourceName TEXT,'
      'collect_status INTEGER,'
      'download_status INTEGER,'
      'download_path TEXT'
      ')',
    );
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 鏃х増琛ㄧ粨鏋勬湁绫诲瀷閿欒锛坉ownload_path INTEGER锛変笖鏃犳硶 ALTER 鏀圭被鍨嬶紝
    // 寮€鍙戝熀绾跨洿鎺ラ噸寤猴紙浼氫涪澶辨湰鍦版敹钘?涓嬭浇璁板綍锛夈€?    await db.execute('DROP TABLE IF EXISTS ${MyDateBaseValue.Tag}');
    await db.execute('DROP TABLE IF EXISTS ${MyDateBaseValue.Image}');
    await onCreate(db, newVersion);
  }

  @override
  Future<ImageModel?> fetchImageById(int id) {
    return _imageDao.getImageById(id);
  }

  @override
  Future<List<ImageModel>> fetchImageByPage(int page, int limit) {
    return _imageDao.getAllCollectedImage(page, limit);
  }

  @override
  Future<List<ImageModel>> fetchImageByTag(String tag, int page, int limit) {
    throw UnimplementedError('鏁版嵁搴撴殏鏃朵笉鏀寔鎼滅储 tag');
  }

  @override
  Future<bool> isImageExistById(int id) {
    return _imageDao.isImageExistById(id);
  }

  @override
  Future<void> updateDownloadImageStatus(ImageModel image) {
    return _imageDao.updateDownloadImageStatus(image);
  }

  @override
  Future<void> collectImage(ImageModel image) {
    return _imageDao.collectImage(image);
  }

  @override
  Future<List<TagModel>> getAllBlockTag() {
    return _tagDao.getAllBlockTag();
  }

  @override
  Future<List<TagModel>> getAllCollectTag() {
    return _tagDao.getAllCollectTag();
  }

  @override
  Future<List<ImageModel>> getAllCollectedImage() {
    return _imageDao.getAllCollectedImage(0, 200);
  }

  @override
  Future<void> saveTag(TagModel tag) {
    return _tagDao.saveTag(tag);
  }
}
```

- [ ] **Step 2: 閲嶅啓 `lib/dao/image_dao.dart`锛堝叏閮ㄥ弬鏁板寲锛屼慨姝ｇ被鍨嬶級**

```dart
import 'package:sqflite/sqflite.dart';
import 'package:yande/model/image_model.dart';
import 'init_dao.dart';

class ImageDao {
  final DaoDataSource source;

  ImageDao(this.source);

  Future<ImageModel?> getImageById(int id, [Database? database]) async {
    final close = database == null;
    final db = database ?? await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[id],
        limit: 1,
      );
      return list.isEmpty
          ? null
          : ImageModel.fromJson(Map<String, dynamic>.from(list.first));
    } catch (e) {
      return null;
    } finally {
      if (close) await db.close();
    }
  }

  Future<bool> isImageExistById(int id, [Database? database]) async {
    final close = database == null;
    final db = database ?? await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        columns: <String>[ImageTableColumn.id],
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[id],
        limit: 1,
      );
      return list.isNotEmpty;
    } catch (e) {
      return false;
    } finally {
      if (close) await db.close();
    }
  }

  Future<bool> collectImage(ImageModel image) async {
    final db = await source.getDatabase();
    try {
      final exists = await isImageExistById(image.id ?? -1, db);
      if (!exists) {
        await db.insert(
          MyDateBaseValue.Image,
          _ImageDaoUtils.toDbMap(image),
        );
      } else {
        await db.update(
          MyDateBaseValue.Image,
          <String, Object?>{
            ImageTableColumn.collectStatus: image.collectStatus?.index,
          },
          where: '${ImageTableColumn.id} = ?',
          whereArgs: <Object?>[image.id],
        );
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      await db.close();
    }
  }

  Future<void> updateDownloadImageStatus(ImageModel image) async {
    final db = await source.getDatabase();
    try {
      final exists = await isImageExistById(image.id ?? -1, db);
      if (!exists) {
        await db.insert(
          MyDateBaseValue.Image,
          _ImageDaoUtils.toDbMap(image),
        );
      } else {
        final values = <String, Object?>{
          ImageTableColumn.downloadStatus: image.downloadStatus?.index,
        };
        if (image.downloadStatus == ImageDownloadStatus.success) {
          values[ImageTableColumn.downloadPath] = image.downloadPath;
        }
        await db.update(
          MyDateBaseValue.Image,
          values,
          where: '${ImageTableColumn.id} = ?',
          whereArgs: <Object?>[image.id],
        );
      }
    } finally {
      await db.close();
    }
  }

  Future<List<ImageModel>> getAllCollectedImage(int page, int limit) async {
    final db = await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        where: '${ImageTableColumn.collectStatus} = ?',
        whereArgs: <Object?>[ImageCollectStatus.star.index],
        offset: (page - 1) * limit,
        limit: limit,
      );
      return list
          .map((item) => ImageModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      return <ImageModel>[];
    } finally {
      await db.close();
    }
  }

  Future<void> updateCollectStatus(
    ImageModel image, [
    Database? database,
  ]) async {
    final close = database == null;
    final db = database ?? await source.getDatabase();
    try {
      await db.update(
        MyDateBaseValue.Image,
        <String, Object?>{
          ImageTableColumn.collectStatus: image.collectStatus?.index,
        },
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[image.id],
      );
    } finally {
      if (close) await db.close();
    }
  }
}

class _ImageDaoUtils {
  static Map<String, Object?> toDbMap(ImageModel image) {
    return <String, Object?>{
      ImageTableColumn.id: image.id,
      ImageTableColumn.tags: image.tags,
      ImageTableColumn.author: image.author,
      ImageTableColumn.fileUrl: image.fileUrl,
      ImageTableColumn.source: image.source,
      ImageTableColumn.fileSize: image.fileSize,
      ImageTableColumn.fileExt: image.fileExt,
      ImageTableColumn.previewUrl: image.previewUrl,
      ImageTableColumn.previewWidth: image.previewWidth,
      ImageTableColumn.previewHeight: image.previewHeight,
      ImageTableColumn.rating: image.rating,
      ImageTableColumn.width: image.width,
      ImageTableColumn.height: image.height,
      ImageTableColumn.sampleUrl: image.sampleUrl,
      ImageTableColumn.jpegUrl: image.jpegUrl,
      ImageTableColumn.jpegWidth: image.jpegWidth,
      ImageTableColumn.jpegHeight: image.jpegHeight,
      ImageTableColumn.jpegFileSize: image.jpegFileSize,
      ImageTableColumn.dataSourceName: image.dataSourceName,
      ImageTableColumn.collectStatus: image.collectStatus?.index,
      ImageTableColumn.downloadStatus: image.downloadStatus?.index,
      ImageTableColumn.downloadPath: image.downloadPath,
    };
  }
}
```

- [ ] **Step 3: 淇?`lib/dao/tag_dao.dart`锛堢┖瀹夊叏銆佺┖鍒楄〃銆佷慨澶?getAllCollectTag 杩囨护锛?*

瑕佺偣锛?
```dart
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
  } finally {
    await db.close();
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
  } finally {
    await db.close();
  }
}
```

鍏朵綑鏂规硶锛坄isTagExistByName`銆乣saveTag`銆乣updateCollectStatus`锛夋妸 `return null` 鏀逛负 `return false`/`return true`锛宍List list =` 鏀逛负绫诲瀷鍖栭亶鍘嗭紱`saveTag` 鐨?insert/update 鏀圭敤鍙傛暟鍖栵細

```dart
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
  } finally {
    await db.close();
  }
}
```

- [ ] **Step 4: 鍐?DAO 娴嬭瘯锛坰qflite_common_ffi锛?*

`test/dao/image_dao_test.dart`锛?
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';

void main() {
  late DaoDataSource source;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    source = DaoDataSource(
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
  });

  ImageModel sampleImage() => ImageModel.fromJson({
        'id': 7,
        'tags': 'solo long_hair',
        'author': 'someone',
        'file_url': 'http://example.com/file.jpg',
        'file_ext': 'jpg',
        'preview_url': 'http://example.com/preview.jpg',
        'rating': 's',
        'width': 100,
        'height': 200,
      });

  test('collect then fetch merges status', () async {
    final image = sampleImage();
    await source.collectImage(image);

    final loaded = await source.fetchImageById(7);
    expect(loaded, isNotNull);
    expect(loaded!.id, 7);
    expect(loaded.collectStatus, ImageCollectStatus.star);
  });

  test('updateDownloadImageStatus persists path', () async {
    final image = sampleImage();
    await source.updateDownloadImageStatus(image);

    final updated = sampleImage()
      ..downloadStatus = ImageDownloadStatus.success
      ..downloadPath = '/data/7.jpg';
    await source.updateDownloadImageStatus(updated);

    final loaded = await source.fetchImageById(7);
    expect(loaded!.downloadStatus, ImageDownloadStatus.success);
    expect(loaded.downloadPath, '/data/7.jpg');
  });

  test('uncollected images are not returned', () async {
    final image = sampleImage()..collectStatus = ImageCollectStatus.unStar;
    await source.collectImage(image);
    final all = await source.getAllCollectedImage();
    expect(all, isEmpty);
  });
}
```

`test/dao/tag_dao_test.dart`锛?
```dart
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
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
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
```

- [ ] **Step 5: 璺戝叏閮ㄦ祴璇曚笌鍒嗘瀽**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
```

Expected: 闄?view 灞傚鍏ㄩ儴閫氳繃锛沗analyze` 鍓╀綑閿欒闆嗕腑鍦?`lib/view` 涓?`lib/widget`銆?
- [ ] **Step 6: 鎻愪氦**

```powershell
git add lib/dao test/dao
git commit -m "feat: parameterized dao queries with schema v3 and injectable database"
```

---

### Task 7: Widget 涓?View 灞傝縼绉伙紙cached_network_image 3 / Material 3 / 绌哄畨鍏級

**Files:**
- Modify: `lib/widget/imageGrid/imageCard.dart`銆乣lib/widget/images.dart`銆乣lib/widget/imageGrid/myImageLazyLoadGrid.dart`銆乣lib/widget/imageGrid/lazyloadView.dart`
- Modify: `lib/widget/dialog.dart`銆乣lib/widget/button.dart`銆乣lib/widget/tagDialog/tagDialog.dart`
- Delete: `lib/widget/rich_text.dart`锛堟湭浣跨敤锛?- Modify: `lib/view/index/indexView.dart`銆乣lib/view/index/components/drawer.dart`
- Modify: `lib/view/search/searchView.dart`銆乣lib/view/search/resultView.dart`
- Modify: `lib/view/collectView/collectImageView.dart`銆乣lib/view/download/downloadView.dart`
- Modify: `lib/view/setting/settingView.dart`銆乣lib/view/setting/subview/dirPickerView.dart`
- Modify: `lib/view/imageStatus/imageStatusView.dart` 鍙婂叾 components
- Modify: `lib/view/imageGallery/imageGalleryView.dart`銆乣lib/utils/fileUtils.dart`
- Create: `test/widget/image_card_test.dart`

**Interfaces:**
- Consumes: `ImageModel`锛圱ask 3锛夈€乣CacheService`锛圱ask 4锛夈€?- Produces: `MainImageCard` 澧炲姞鍙€?`imageBuilder`锛堟祴璇曟敞鍏ョ敤锛夈€?
- [ ] **Step 1: 鍏ㄥ眬鏈烘鏇挎崲锛堢┖瀹夊叏闆嗗悎瀛楅潰閲?+ `@required`锛?*

```powershell
rg -n "= List\(\)|Map\(\)" lib -g '*.dart'
rg -n "@required" lib -g '*.dart'
```

鎶?`List()` 鏀逛负 `[]`銆乣Map()` 鏀逛负 `{}`锛堝埄鐢ㄥ０鏄庡鐨勭被鍨嬫帹鏂級锛屾妸 `@required this.x` 鏀逛负 `required this.x`锛堟瀯閫犲嚱鏁板弬鏁帮級锛屽垹闄や笉鍐嶉渶瑕佺殑 `@required` 娉ㄨВ銆傞€愪釜鏂囦欢澶勭悊锛屽鐞嗗畬鍐嶈窇 `flutter analyze` 鏀舵暃銆?
- [ ] **Step 2: 閲嶅啓 `lib/widget/imageGrid/imageCard.dart`锛坈ached_network_image 3 + imageBuilder 娉ㄥ叆锛?*

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/widget/progress.dart';

typedef ImageTapCallBack = void Function(ImageModel);

const cardTopBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
);

const cardBottomBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
);

class MainImageCard extends StatelessWidget {
  final ImageModel imageModel;
  final GestureTapCallback? collectEvent;
  final GestureTapCallback? downloadEvent;
  final ImageTapCallBack? imageTap;
  final GestureLongPressCallback? onLongPress;
  final String? heroPrefix;

  /// 娴嬭瘯娉ㄥ叆鐢細鏇挎崲鍥剧墖灞曠ず widget锛岄伩鍏嶆祴璇曢噷瑙﹀彂缃戠粶鍥剧墖鍔犺浇銆?  final Widget Function(ImageModel image)? imageBuilder;

  MainImageCard(
    this.imageModel, {
    this.collectEvent,
    this.downloadEvent,
    this.onLongPress,
    this.imageTap,
    this.heroPrefix,
    this.imageBuilder,
  }) : assert(imageModel != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  _buildImageBlockWidget(imageModel),
                  _buildImageSizeText(imageModel),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: cardBottomBorderDecoration,
              child: Row(
                children: <Widget>[
                  _CollectButton(
                    status: imageModel.isCollect(),
                    onTap: collectEvent,
                  ),
                  _DownloadButton(
                    status: imageModel.downloadStatus,
                    onTap: downloadEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSizeText(ImageModel imageModel) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0x1a000000),
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          '${imageModel.width} x ${imageModel.height}',
          style: const TextStyle(color: Color(0xffffffff)),
        ),
      ),
    );
  }

  Widget _buildImageBlockWidget(ImageModel imageModel) {
    return Center(
      child: Container(
        decoration: cardTopBorderDecoration,
        child: GestureDetector(
          onTap: () => imageTap?.call(imageModel),
          child: Hero(
            tag: '$heroPrefix${imageModel.id}',
            child: imageBuilder != null
                ? imageBuilder!(imageModel)
                : CachedNetworkImage(
                    placeholder: (_, __) =>
                        const ImageCardCircularProgressIndicator(),
                    imageUrl: imageModel.previewUrl ?? '',
                  ),
          ),
        ),
      ),
    );
  }
}

class _CollectButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool status;

  const _CollectButton({required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return _CardMaterialButton(
      onTap: onTap,
      child: Icon(
        status ? Icons.star : Icons.star_border,
        color: status ? Colors.amberAccent : null,
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final ImageDownloadStatus? status;

  const _DownloadButton({required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return _CardMaterialButton(
      onTap: onTap,
      child: Icon(Icons.file_download, color: getColor()),
    );
  }

  Color getColor() {
    switch (status) {
      case ImageDownloadStatus.success:
        return Colors.amberAccent;
      case ImageDownloadStatus.pending:
        return Colors.blueGrey;
      case ImageDownloadStatus.error:
        return Colors.redAccent;
      case ImageDownloadStatus.none:
      case null:
        return Colors.black;
    }
  }
}

class _CardMaterialButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;

  const _CardMaterialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 85,
            height: 30,
            child: child,
          ),
        ),
      ),
    );
  }
}

class ImageGalleryCard extends StatelessWidget {
  final ImageModel image;
  final ImageTapCallBack? imageTap;
  final GestureLongPressCallback? onLongPress;
  final String? heroPrefix;

  ImageGalleryCard(
    this.image, {
    this.onLongPress,
    this.imageTap,
    this.heroPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: SizedBox(
          height: 140,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: GestureDetector(
              onTap: () => imageTap?.call(image),
              child: Hero(
                tag: '$heroPrefix${image.id}',
                child: CachedNetworkImage(
                  placeholder: (_, __) =>
                      const ImageCardCircularProgressIndicator(),
                  imageUrl: image.previewUrl ?? '',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

`ImageCardCircularProgressIndicator` 鏀规瀯閫犲嚱鏁颁负 `const`锛坄lib/widget/progress.dart`锛夛細

```dart
class ImageCardCircularProgressIndicator extends StatelessWidget {
  const ImageCardCircularProgressIndicator({super.key});
  ...
}
```

- [ ] **Step 3: 淇?`lib/widget/images.dart`锛堝垹姝讳唬鐮?+ placeholder 绛惧悕锛?*

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yande/widget/progress.dart';

class MyCachedImage extends StatelessWidget {
  final String? url;

  const MyCachedImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => const ImageCardCircularProgressIndicator(),
      imageUrl: url ?? '',
      fit: BoxFit.cover,
    );
  }
}
```

- [ ] **Step 4: 淇?`lib/widget/dialog.dart`锛圱extButton + url_launcher 6锛?*

```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yande/service/updateService.dart';

class UpdateDialog extends StatelessWidget {
  final String? version;
  final String? text;
  final String? url;

  const UpdateDialog({super.key, this.version, this.text, this.url});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('鏂扮増鏈凡缁忓彂甯?),
      content: Text(text ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (version != null) {
              UpdateService.ignoreUpdateVersion(version!);
            }
            Navigator.pop(context);
          },
          child: const Text('蹇界暐姝ょ増鏈?),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('鏆傛椂涓?),
        ),
        TextButton(
          onPressed: () async {
            final uri = Uri.tryParse(url ?? '');
            if (uri != null && await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text('鏇存柊'),
        ),
      ],
    );
  }
}
```

- [ ] **Step 5: 淇?snackbar 鐢ㄦ硶锛? 涓枃浠讹級**

鎶?`indexView.dart`銆乣resultView.dart`銆乣collectImageView.dart`銆乣imageStatusView.dart`銆乣settingView.dart` 涓殑锛?
```dart
_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
```

鏇挎崲涓猴細

```dart
ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text(text)));
```

骞跺垹闄や笉鍐嶄娇鐢ㄧ殑 `_scaffoldKey` 瀛楁锛堝鍙墿 snackbar 鐢ㄩ€旓級銆俙imageStatusView.dart` 涓?`widget.image.tagTagModelList.map(...)` 鍓嶅姞绌轰繚鎶わ細

```dart
children: (widget.image.tagTagModelList ?? <TagModel>[])
    .map((tag) => _buildSearchChip(tag))
    .toList(),
```

鍚屾椂鎶?`imageStatusView.dart:150`銆乣drawer.dart:103` 鐨?`MaterialButton` 鎹㈡垚 `FilledButton`锛坈hild 涓嶅彉锛夛紝`imageStatusView._buildLargeButton` 鍙傛暟 `{Function onPressed}` 鏀逛负 `{VoidCallback? onPressed}`銆?
- [ ] **Step 6: 淇浘鐗囧睍绀虹浉鍏筹紙placeholder 绛惧悕 + accentColor锛?*

- `lib/view/imageStatus/components/imageStatusAppBar.dart`锛氫袱澶?`placeholder: ImageCardCircularProgressIndicator()` 鏀逛负 `placeholder: (_, __) => const ImageCardCircularProgressIndicator()`锛沗Theme.of(context).accentColor` 鏀逛负 `Theme.of(context).colorScheme.secondary`銆?- `lib/view/imageGallery/imageGalleryView.dart`锛歚CachedNetworkImageProvider` 淇濇寔涓嶅彉锛坈ached_network_image 3 浠嶅鍑猴級锛宲hoto_view ^0.15 鍏煎銆?- `lib/view/search/searchView.dart`锛歚tag.type >= 0 && tag.type <= 3` 鍓嶅姞 `tag.type != null` 鍒ゆ柇銆?- `lib/view/setting/subview/dirPickerView.dart`锛歚getRootPath()` 鏀逛负 `rootPath = (await getApplicationDocumentsDirectory()).path;`锛屽垹闄ゆ棫瀵煎叆鍐茬獊銆?- `lib/utils/fileUtils.dart`锛氬垹闄?`getExternalDir()` 涓?`getExternalDatabaseDir()`锛堝凡鏃犺皟鐢ㄦ柟锛夛紝淇濈暀 `getDirAndCreate` 涓?`getAllDirectoryChildren`銆?- `lib/widget/tagDialog/tagDialog.dart`銆乣lib/widget/button.dart`锛氫粎绌哄畨鍏ㄦ満姊颁慨鏀癸紙`List()` 鈫?`[]` 绛夛級锛屾枃妗堜笉鍔ㄣ€?- `lib/view/download/downloadView.dart`锛氫粎绌哄畨鍏ㄦ満姊颁慨鏀广€?- `lib/widget/rich_text.dart`锛氱‘璁?`rg -n "LinkTextSpan" lib` 鏃犱娇鐢ㄥ悗鍒犻櫎銆?
- [ ] **Step 7: 鍐欑粍浠舵祴璇?`test/widget/image_card_test.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/widget/imageGrid/imageCard.dart';

void main() {
  testWidgets('MainImageCard renders size and star, taps image', (
    tester,
  ) async {
    final image = ImageModel.fromJson({
      'id': 1,
      'width': 100,
      'height': 200,
      'preview_url': 'http://example.com/p.jpg',
    });
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MainImageCard(
            image,
            imageBuilder: (_) => const ColoredBox(color: Colors.grey),
            imageTap: (_) => tapped = true,
            collectEvent: () {},
            downloadEvent: () {},
            heroPrefix: 'test',
          ),
        ),
      ),
    );

    expect(find.text('100 x 200'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.byType(GestureDetector).first);
    expect(tapped, isTrue);
  });
}
```

- [ ] **Step 8: 璺戞祴璇曚笌鍒嗘瀽鐩村埌鏀舵暃**

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
```

Expected: `flutter analyze` 杈撳嚭 `No issues found!`锛宍flutter test` 鍏ㄧ豢銆傝嫢鏈夐仐鐣欐姤閿欙紝鎸夋姤閿欐枃浠堕€愪釜澶勭悊锛堝涓?`List()` 鏈被鍨嬪寲銆乣@required`銆佹棫 API锛夈€?
- [ ] **Step 9: 鎻愪氦**

```powershell
git add lib/widget lib/view lib/utils test/widget
git commit -m "feat: migrate widgets and views to modern Flutter APIs"
```

---

### Task 8: Android 骞冲彴杩佺Щ锛坴2 embedding + Gradle 8 + 鏃犵鍚嶅瘑閽ワ級

**Files:**
- Delete: `android/`锛堟棫宸ョ▼锛屽惈 v1 embedding銆乯center銆佺鍚嶅瘑閽ワ級
- Regenerate: `android/`锛坄flutter create`锛?- Modify: `android/app/src/main/kotlin/xyz/xiaopo/yande/MainActivity.kt`
- Create: `android/app/src/main/kotlin/xyz/xiaopo/yande/plugins/ScanImageFileBroadCastPlugin.kt`
- Modify: `android/app/src/main/AndroidManifest.xml`

**Interfaces:**
- Consumes: `ScanImagePlugins`锛圖art MethodChannel 鍚?`scan_image_file_broad_cast`锛屾柟娉?`broadcast`锛夈€?- Produces: v2 `FlutterActivity` + 鑷畾涔夋彃浠舵敞鍐岋紱debug APK 鏋勫缓閫氳繃銆?
- [ ] **Step 1: 閲嶅缓 Android 骞冲彴鐩綍**

```powershell
git rm -r android
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" create --platforms=android --org xyz.xiaopo --project-name yande .
```

Expected: 鐢熸垚鏂扮殑 `android/`锛坘otlin 妯℃澘銆丄GP 8.x銆丟radle 8.x銆佹棤 jcenter锛夈€傛敞鎰忥細launcher 鍥炬爣琚浛鎹负榛樿鍥炬爣锛堣寖鍥村锛屽彲鍚庣画鎭㈠锛夈€?
- [ ] **Step 2: 杩佺Щ鑷畾涔夋彃浠跺埌 v2 API**

鍒涘缓 `android/app/src/main/kotlin/xyz/xiaopo/yande/plugins/ScanImageFileBroadCastPlugin.kt`锛?
```kotlin
package xyz.xiaopo.yande.plugins

import android.content.Context
import android.media.MediaScannerConnection
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class ScanImageFileBroadCastPlugin private constructor(
    private val context: Context,
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodChannel.MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "broadcast" -> {
                val path = call.argument<String>("path")
                if (path != null) {
                    MediaScannerConnection.scanFile(context, arrayOf(path), null, null)
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    companion object {
        private const val CHANNEL = "scan_image_file_broad_cast"

        fun registerWith(engine: FlutterEngine) {
            val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
            channel.setMethodCallHandler(ScanImageFileBroadCastPlugin(engine.applicationContext))
        }
    }
}
```

璇存槑锛氭棫鐨?`ACTION_MEDIA_SCANNER_SCAN_FILE` 骞挎挱鍦?API 29+ 宸插簾寮冿紝鏀逛负 `MediaScannerConnection.scanFile`銆?
鏀瑰啓 `MainActivity.kt`锛?
```kotlin
package xyz.xiaopo.yande

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import xyz.xiaopo.yande.plugins.ScanImageFileBroadCastPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        ScanImageFileBroadCastPlugin.registerWith(flutterEngine)
    }
}
```

- [ ] **Step 3: 淇?Manifest锛堝幓瀛樺偍鏉冮檺銆佷繚 label锛?*

`android/app/src/main/AndroidManifest.xml`锛氬垹闄?`WRITE_EXTERNAL_STORAGE` 鏉冮檺锛堜笅杞藉凡鏀瑰埌搴旂敤鏂囨。鐩綍锛夛紝淇濈暀 `INTERNET`锛沗android:label="yande"` 淇濇寔锛沴auncher activity 鐨?`android:exported="true"` 鐢辨ā鏉跨敓鎴愶紙targetSdk 31+ 蹇呴渶锛夈€?
- [ ] **Step 4: 妫€鏌?gradle 鏃犵鍚嶅瘑閽?*

```powershell
rg -n "keyPassword|storeFile|jcenter|signingConfig" android
```

Expected: 鏃犺緭鍑猴紙鎴栦粎妯℃澘榛樿娉ㄩ噴锛夈€傜‘璁?`android/app/build.gradle` 浣跨敤 `namespace 'xyz.xiaopo.yande'`銆乣minSdk = flutter.minSdkVersion`銆?
- [ ] **Step 5: 鏋勫缓 debug APK锛堥渶瑕?Task 1 鐨?Android SDK锛?*

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" build apk --debug
```

Expected: `Built build\app\outputs\flutter-apk\app-debug.apk`銆?
- [ ] **Step 6: 鎻愪氦**

```powershell
git add android
git commit -m "feat: migrate Android embedding to v2 and rebuild gradle toolchain"
```

---

### Task 9: 娴嬭瘯鏀跺熬 + CI + README

**Files:**
- Delete: `test/widget_test.dart`锛堟ā鏉胯鏁板櫒娴嬭瘯锛?- Create: `.github/workflows/flutter-ci.yml`
- Modify: `README.md`

**Interfaces:** 鏃犳柊鎺ュ彛锛涙湰浠诲姟鏄叏椤圭洰闂ㄧ鏀跺彛銆?
- [ ] **Step 1: 鍒犻櫎妯℃澘娴嬭瘯**

```powershell
git rm test/widget_test.dart
```

璇存槑锛氬凡鏈?`test/models`銆乣test/services`銆乣test/http`銆乣test/dao`銆乣test/widget` 瑕嗙洊鏍稿績閫昏緫锛涘畬鏁?App 鍐掔儫闇€鐪熸満/妯℃嫙鍣紙鑼冨洿澶栵級銆?
- [ ] **Step 2: 鍒涘缓 `.github/workflows/flutter-ci.yml`锛堜簯绔獙璇侊紝鏃犻渶鏈満 Flutter锛?*

```yaml
name: Flutter CI

on:
  push:
    branches: [master, codex/**]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --debug
```

娉ㄦ剰锛歚origin` 鏄敤鎴疯嚜宸辩殑 fork锛圔otaniii/yande锛夛紝鍒嗘敮灏辩华鍚庡彲鑷敱 push 鍒拌 fork锛孋I 浼氶殢涔嬭繍琛屻€?
- [ ] **Step 3: 鏇存柊 `README.md` 鏋勫缓绔犺妭**

鎶?"build" 涓€鑺傛浛鎹负锛?
````markdown
## build

1. 瀹夎 Flutter stable锛堜究鎼?zip 鎴?git clone 鍧囧彲锛夈€?2. 杩愯 `flutter pub get` 鑾峰彇渚濊禆銆?3. 杩愯 `dart run build_runner build --delete-conflicting-outputs` 閲嶆柊鐢熸垚
   `lib/model/*.g.dart`锛堟灇涓惧簭鍒楀寲鐢?`@JsonValue` 娉ㄨВ淇濊瘉锛屾棤闇€鎵嬪伐鏀?map锛夈€?4. 杩愯 `flutter test` 涓?`flutter analyze` 楠岃瘉銆?5. 杩愯 `flutter build apk --debug`锛孉PK 浣嶄簬
   `build/app/outputs/flutter-apk/app-debug.apk`銆?
> 娉ㄦ剰锛歳elease 绛惧悕宸蹭粠浠撳簱绉婚櫎锛屾墦鍖?release 闇€鑷閰嶇疆鏈湴 keystore锛堢幆澧冨彉閲忔柟寮忥級銆?````

- [ ] **Step 4: 鍏ㄩ」鐩棬绂?*

```powershell
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" pub get
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" analyze
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" test
& "C:\Users\admin\Desktop\zcode-program\yande-remake\flutter\bin\flutter.bat" build apk --debug
```

Expected: analyze `No issues found!`锛泃est 鍏ㄧ豢锛汚PK 鏋勫缓鎴愬姛銆?
- [ ] **Step 5: 鎻愪氦**

```powershell
git add .github README.md
git rm test/widget_test.dart
git commit -m "chore: add CI workflow and update README build instructions"
```

---

## Self-Review 璁板綍

- **Spec 瑕嗙洊**锛氬伐鍏烽摼锛圱ask 1锛夈€佷緷璧?绌哄畨鍏紙Task 3锛夈€佸紩瀵间笌 service锛圱ask 4锛夈€乭ttp锛圱ask 5锛夈€佹暟鎹簱锛圱ask 6锛夈€乁I锛圱ask 7锛夈€丄ndroid锛圱ask 8锛夈€佹祴璇曚笌 CI锛圱ask 9锛夛紝瑕嗙洊 README 鍏ㄩ儴鍔熻兘鐐癸紙娴忚/鎼滅储/涓嬭浇/鏀惰棌/蹇嵎 tag/璁剧疆/鏇存柊妫€鏌ワ級銆?- **鍗犱綅绗︽壂鎻?*锛氭棤 TBD/TODO锛涙墍鏈変唬鐮佹楠ゅ惈瀹屾暣浠ｇ爜鎴栨槑纭満姊拌鍒欍€?- **绫诲瀷涓€鑷存€?*锛歚AppDataSource.fetchImageById` 缁熶竴杩斿洖 `Future<ImageModel?>`锛沗DaoDataSource`/`YandeHttpDataSource` 瀹炵幇绛惧悕涓€鑷达紱`TagCollectStatus.block` 鍦ㄦā鍨嬨€丏AO銆佹祴璇曚笁澶勪竴鑷翠负 2锛沗applyFilterRank` 璇箟涓庢棫 `_imageFilter` 涓€鑷淬€?