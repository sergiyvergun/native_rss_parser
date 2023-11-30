import 'dart:convert';
import 'dart:io';

import 'package:native_rss_parser/rss_feed_item.dart';

import 'native_rss_parser_platform_interface.dart';

class NativeRssParser {
  Future<List<RssFeedItem>> parseRss(String url) async {
    List jsonResult =
        jsonDecode(await NativeRssParserPlatform.instance.parseRss(url));

    return jsonResult.map((json) {
      if (Platform.isIOS) {
        return RssFeedItem.fromIOSJson(json);
      } else {
        return RssFeedItem.fromAndroidJson(json);
      }
    }).toList();
  }
}
