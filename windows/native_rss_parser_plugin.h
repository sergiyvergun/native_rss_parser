#ifndef FLUTTER_PLUGIN_NATIVE_RSS_PARSER_PLUGIN_H_
#define FLUTTER_PLUGIN_NATIVE_RSS_PARSER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace native_rss_parser {

class NativeRssParserPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NativeRssParserPlugin();

  virtual ~NativeRssParserPlugin();

  // Disallow copy and assign.
  NativeRssParserPlugin(const NativeRssParserPlugin&) = delete;
  NativeRssParserPlugin& operator=(const NativeRssParserPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace native_rss_parser

#endif  // FLUTTER_PLUGIN_NATIVE_RSS_PARSER_PLUGIN_H_
