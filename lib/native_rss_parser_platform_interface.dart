import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_rss_parser_method_channel.dart';

abstract class NativeRssParserPlatform extends PlatformInterface {
  /// Constructs a NativeRssParserPlatform.
  NativeRssParserPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeRssParserPlatform _instance = MethodChannelNativeRssParser();

  /// The default instance of [NativeRssParserPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeRssParser].
  static NativeRssParserPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeRssParserPlatform] when
  /// they register themselves.
  static set instance(NativeRssParserPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future parseRss(String url) {
    throw UnimplementedError('parseRss() has not been implemented.');
  }
}
