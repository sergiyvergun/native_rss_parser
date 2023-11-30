import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:native_rss_parser/native_rss_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nativeRssParserPlugin = NativeRssParser();

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final result = await _nativeRssParserPlugin.parseRss(
                    "https://ain.ua/feed/");
                print(result);
              } on PlatformException catch (e) {
                print(e.message);
              }
            },
            child: const Text("Parse RSS"),
          ),
        ),
      ),
    );
  }
}
