
import 'package:hyll_ag/data/feed.dart';

class FeedCollection {
  static FeedCollection? _instance;

  final List<Feed> _feeds = [];

  FeedCollection._();

  static FeedCollection instance() {
    _instance ??= FeedCollection._();
    return _instance!;
  }

  List<Feed> get all => _feeds.toList(growable: false);

  void add(List<Feed> items) => _feeds.addAll(items);
}
