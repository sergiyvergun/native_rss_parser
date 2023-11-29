import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_rss_parser_platform_interface.dart';

/// An implementation of [NativeRssParserPlatform] that uses method channels.
class MethodChannelNativeRssParser extends NativeRssParserPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_rss_parser');


  @override
  Future parseRss(String url) async {
    final version =
        await methodChannel.invokeMethod<String>('parseRss', {"url": url});
    return version;
  }
}
