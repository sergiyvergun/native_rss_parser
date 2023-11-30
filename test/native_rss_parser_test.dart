import 'package:flutter_test/flutter_test.dart';
import 'package:native_rss_parser/native_rss_parser.dart';
import 'package:native_rss_parser/native_rss_parser_platform_interface.dart';
import 'package:native_rss_parser/native_rss_parser_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeRssParserPlatform
    with MockPlatformInterfaceMixin
    implements NativeRssParserPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeRssParserPlatform initialPlatform = NativeRssParserPlatform.instance;

  test('$MethodChannelNativeRssParser is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeRssParser>());
  });

  test('getPlatformVersion', () async {
    NativeRssParser nativeRssParserPlugin = NativeRssParser();
    MockNativeRssParserPlatform fakePlatform = MockNativeRssParserPlatform();
    NativeRssParserPlatform.instance = fakePlatform;

    expect(await nativeRssParserPlugin.getPlatformVersion(), '42');
  });
}
