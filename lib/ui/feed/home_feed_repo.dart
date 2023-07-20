import 'package:hyll_ag/backend/shared_web_service.dart';
import 'package:hyll_ag/collection/feed_collection.dart';
import 'package:hyll_ag/data/list_type_item.dart';

class HomeFeedRepo {
  final FeedCollection _feedCollection;
  final SharedWebService _sharedWebService;

  String? _nextPageUrl;

  HomeFeedRepo(this._feedCollection, this._sharedWebService);

  Future<List<dynamic>?> requestFeed() async {
    try {
      final homeFeed = await _sharedWebService.requestFeed(nextUrl: _nextPageUrl);
      _nextPageUrl = homeFeed.next;
      _feedCollection.add(homeFeed.feeds);

      final List<dynamic> allFeeds = List<dynamic>.of(_feedCollection.all);
      homeFeed.next == null ? allFeeds.add(const DonePageItem()) : allFeeds.add(PaginatedItem.initial());
      return allFeeds;
    } catch (e_) {
      return null;
    }
  }
}
