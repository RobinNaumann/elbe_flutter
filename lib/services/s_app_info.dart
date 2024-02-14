import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import '../elbe.dart';

enum RunPlatform {
  web,
  android,
  ios,
  macos,
  windows,
  linux,
  fuchsia;

  bool get isWeb => this == RunPlatform.web;
  bool get isAndroid => this == RunPlatform.android;
  bool get isIos => this == RunPlatform.ios;
  bool get isMacos => this == RunPlatform.macos;
  bool get isWindows => this == RunPlatform.windows;
  bool get isLinux => this == RunPlatform.linux;
  bool get isFuchsia => this == RunPlatform.fuchsia;
}

/// this is a shorthand for AppInfoService.i.platform. Make sure to initialize AppInfoService before using this.
RunPlatform get runPlatform => AppInfoService.i.platform;

abstract class AppInfoService {
  static AppInfoService? _i;
  static AppInfoService get i => serviceInst(_i);

  /// provide a custom app info service. For basic console logging, use BasicAppInfoService.
  static void init(AppInfoService i) => _i = _i ?? i;

  /// the app's name
  String get appName;

  /// the app's package name
  String get packageName;

  /// the app's version
  String get version;

  /// the app's build number
  String get buildNr;

  String get fullVersion => "$version+$buildNr";

  /// the current platform
  RunPlatform get platform;

  /// whether the app is running on a real device (not in the simulator)
  Future<bool> get deviceIsPhysical;
}

class BasicAppInfoService extends AppInfoService {
  final PackageInfo packageInfo;
  final DeviceInfoPlugin deviceInfo;

  BasicAppInfoService._({required this.packageInfo, required this.deviceInfo});

  static Future<BasicAppInfoService> make() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    return BasicAppInfoService._(
        packageInfo: packageInfo, deviceInfo: deviceInfo);
  }

  @override
  get buildNr => packageInfo.buildNumber;

  @override
  get appName => packageInfo.appName;

  @override
  get packageName => packageInfo.packageName;

  @override
  get version => packageInfo.version;

  @override
  get platform {
    if (Platform.isAndroid) return RunPlatform.android;
    if (Platform.isIOS) return RunPlatform.ios;
    if (Platform.isMacOS) return RunPlatform.macos;
    if (Platform.isWindows) return RunPlatform.windows;
    if (Platform.isLinux) return RunPlatform.linux;
    if (Platform.isFuchsia) return RunPlatform.fuchsia;
    return RunPlatform.web;
  }

  @override
  get deviceIsPhysical async => platform.isIos
      ? (await deviceInfo.iosInfo).isPhysicalDevice
      : (platform.isAndroid
          ? (await deviceInfo.androidInfo).isPhysicalDevice
          : true);
}
