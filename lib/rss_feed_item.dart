class RssFeedItem {
  final String? guid;
  final String? title;
  final String? description;
  final String? link;
  final String? author;
  final DateTime? pubDate;

  final String? enclosure;

  RssFeedItem(
      {required this.guid,
      required this.title,
      required this.description,
      required this.link,
      required this.author,
      required this.pubDate,
      required this.enclosure});

  factory RssFeedItem.fromIOSJson(Map<String, dynamic> json) {
    return RssFeedItem(
        title: json['title'],
        description: json['description'],
        link: json['link'],
        author: json['author'],
        pubDate: DateTime.tryParse(json['pubDate']),
        enclosure: json['enclosure'],
        guid: json['guid']);
  }

  factory RssFeedItem.fromAndroidJson(Map<String, dynamic> json) {
    return RssFeedItem(
        title: json['title'],
        description: json['description'],
        link: json['link'],
        author: json['author'],
        pubDate: DateTime.tryParse(json['pubDate']),
        enclosure: json['image'],
        guid: json['guid']);
  }

  @override
  String toString() {
    return 'RssFeedItem{guid: $guid, title: $title, description: $description, link: $link, author: $author, pubDate: $pubDate, enclosure: $enclosure}';
  }
}
