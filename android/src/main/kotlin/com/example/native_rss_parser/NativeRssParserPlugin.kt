package com.example.native_rss_parser

import com.prof18.rssparser.RssParser
import com.prof18.rssparser.model.RssChannel
import com.prof18.rssparser.model.RssItem
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject

class NativeRssParserPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_rss_parser")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "parseRss") {
            val url = call.argument<String>("url")!!
            CoroutineScope(Dispatchers.Main).launch {
                try {
                    val rssItems: List<RssItem> = parseRss(url)
                    val jsonString = convertRssItemsToJsonString(rssItems)
                    result.success(jsonString)
                } catch (e: Exception) {
                    result.error("PARSE_ERROR", "Error parsing RSS: ${e.message}", null)
                }
            }
        } else {
            result.notImplemented()
        }
    }

    suspend fun parseRss(url: String): List<RssItem> {
        val rssParser: RssParser = RssParser()
        val rssChannel: RssChannel = rssParser.getRssChannel(url)
        return rssChannel.items
    }

    private fun convertRssItemsToJsonString(articles: List<RssItem>): String {
        val jsonArray = JSONArray()
        for (article in articles) {
            val jsonObject = JSONObject()
            jsonObject.put("guid", article.guid)
            jsonObject.put("title", article.title)
            jsonObject.put("author", article.author)
            jsonObject.put("link", article.link)
            jsonObject.put("pubDate", article.pubDate)
            jsonObject.put("description", article.description)
            jsonObject.put("content", article.content)
            jsonObject.put("image", article.image)
            jsonObject.put("audio", article.audio)
            jsonObject.put("video", article.video)
            jsonObject.put("sourceName", article.sourceName)
            jsonObject.put("sourceUrl", article.sourceUrl)
            jsonObject.put("categories", JSONArray(article.categories))

            // Handle ItunesItemData
            article.itunesItemData?.let {
                val itunesDataObject = JSONObject()
                itunesDataObject.put("author", it.author)
                itunesDataObject.put("duration", it.duration)
                itunesDataObject.put("episode", it.episode)
                itunesDataObject.put("episodeType", it.episodeType)
                itunesDataObject.put("explicit", it.explicit)
                itunesDataObject.put("image", it.image)
                itunesDataObject.put("keywords", JSONArray(it.keywords))
                itunesDataObject.put("subtitle", it.subtitle)
                itunesDataObject.put("summary", it.summary)
                itunesDataObject.put("season", it.season)
                jsonObject.put("itunesItemData", itunesDataObject)
            }

            jsonObject.put("commentsUrl", article.commentsUrl)
            jsonArray.put(jsonObject)
        }
        return jsonArray.toString()
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
