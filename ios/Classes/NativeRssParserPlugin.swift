import Flutter
import UIKit
import FeedKit

public class NativeRssParserPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_rss_parser", binaryMessenger: registrar.messenger())
        let instance = NativeRssParserPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "parseRss":
            guard let arguments = call.arguments as? [String: Any],
                  let url = arguments["url"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid URL", details: nil))
                return
            }
            
            parseRss(url) { parseResult in
                switch parseResult {
                case .success(let rssFeed):
                    result(rssFeed)
                case .failure(let error):
                    result(FlutterError(code: "PARSING_ERROR", message: "Error parsing RSS", details: "\(error)"))
                }
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func parseRss(_ url: String, completion: @escaping (Result<String, Error>) -> Void) {
        let feedURL = URL(string: url)!
        let parser = FeedParser(URL: feedURL)

        // Parse asynchronously, not to block the UI.
        parser.parseAsync { [weak self] result in
            switch result {
            case .success(let feed):
                guard let items = feed.rssFeed?.items else {
                    completion(.failure(NSError(domain: "ITEMS_ARE_NULL", code: 0, userInfo: nil)))
                    return
                }

                do {
                    // Manually convert each item to a dictionary
                    let itemsArray: [[String: Any]] = items.compactMap { item in
                        var itemDictionary: [String: Any] = [
                            "title": item.title,
                            "link": item.link,
                            "description": item.description,
                            "author": item.author,
                            "comments": item.comments,
                            "guid": item.guid?.value,
                            "pubDate": item.pubDate?.description,
                            "source": item.source?.attributes?.url,
                            "enclosure": item.enclosure?.attributes?.url,
                        ]

                        return itemDictionary
                    }

                    // Convert the array of dictionaries to JSON data
                    let jsonData = try JSONSerialization.data(withJSONObject: itemsArray, options: .prettyPrinted)

                    // Convert JSON data to a string
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        completion(.success(jsonString))
                    } else {
                        completion(.failure(NSError(domain: "JSON_CONVERSION_ERROR", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }

    
}
