import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyll_ag/backend/shared_web_service.dart';
import 'package:hyll_ag/collection/feed_collection.dart';
import 'package:hyll_ag/data/exception.dart';
import 'package:hyll_ag/data/list_type_item.dart';
import 'package:hyll_ag/data/meta_data.dart';
import 'package:hyll_ag/helper/network_helper.dart';
import 'package:hyll_ag/ui/feed/home_feed_bloc_state.dart';
import 'package:hyll_ag/ui/feed/home_feed_repo.dart';
import 'package:hyll_ag/util/app_strings.dart';


class HomeFeedBloc extends Cubit<HomeFeedBlocState> {
  final NetworkHelper _networkHelper = NetworkHelper.instance();

  late HomeFeedRepo _homeFeedRepo;

  HomeFeedBloc() : super(const HomeFeedBlocState.initial()) {
    _homeFeedRepo = HomeFeedRepo(FeedCollection.instance(), SharedWebService.instance());
    requestFeed();

    /// listen to network state changes.
    _networkHelper.onConnectivityChanged.listen((event) {
      /// if the bottom network text is empty then it means nothing showing at the bottom of screen error so return simply.
      if (state.bottomNetworkText.isEmpty) return;

      final lastFeedDataEvent = state.feedDataEvent;

      /// if the feed is currently empty and it is error state then user can try again by pressing on home so need to auto hit the api request.
      if (lastFeedDataEvent is! Data) return;

      final homeFeedItems = lastFeedDataEvent.data as List<dynamic>;
      if (homeFeedItems.isNotEmpty && homeFeedItems.last is! DonePageItem && homeFeedItems.last is! PaginatedItem) {
        homeFeedItems.add(PaginatedItem(isShownOnce: true));

        /// now hide the bottom network error and show again the progress bar.
        emit(state.copyWith(feedDataEvent: Data(data: homeFeedItems), bottomNetworkText: ''));
        requestFeed();
      }
    });
  }

  Future<void> requestFeed() async {
    final lastFeedDataEvent = state.feedDataEvent;
    if (lastFeedDataEvent is! Data) emit(state.copyWith(feedDataEvent: const Loading()));

    final feeds = await _homeFeedRepo.requestFeed();

    /// If we successfully got the home feed data then simply push the newly feeds.
    if (feeds != null) {
      emit(state.copyWith(feedDataEvent: Data(data: feeds)));
      return;
    }

    /// If there is network connected then try again.
    if (await _networkHelper.isNetworkConnected) {
      requestFeed();
      return;
    }

    /// If the network is not connected and there are previously data is showing then show the bottom network error text
    if (lastFeedDataEvent is Data) {
      final List<dynamic> feedsData = lastFeedDataEvent.data as List<dynamic>;

      /// remove the last progress bar item and show the bottom error text.
      feedsData.removeLast();
      emit(state.copyWith(feedDataEvent: Data(data: feedsData), bottomNetworkText: AppStrings.BOTTOM_NETWORK_ERROR_TEXT));
      return;
    }

    /// Last state when it is the first time user open the app and no stable network connection then show network error in the middle of screen.
    emit(state.copyWith(feedDataEvent: const Error(exception: NoInternetConnectException())));
  }
}
