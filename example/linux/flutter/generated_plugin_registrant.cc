//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <native_rss_parser/native_rss_parser_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) native_rss_parser_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "NativeRssParserPlugin");
  native_rss_parser_plugin_register_with_registrar(native_rss_parser_registrar);
}
