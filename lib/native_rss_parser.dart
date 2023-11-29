
import 'native_rss_parser_platform_interface.dart';

class NativeRssParser {

  Future parseRss(String url) {
    return NativeRssParserPlatform.instance.parseRss(url);
  }
}
