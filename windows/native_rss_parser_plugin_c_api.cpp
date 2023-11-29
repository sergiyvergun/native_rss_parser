#include "include/native_rss_parser/native_rss_parser_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_rss_parser_plugin.h"

void NativeRssParserPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_rss_parser::NativeRssParserPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
