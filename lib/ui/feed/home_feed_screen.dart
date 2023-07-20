import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyll_ag/data/feed.dart';
import 'package:hyll_ag/data/list_type_item.dart';
import 'package:hyll_ag/data/meta_data.dart';
import 'package:hyll_ag/extensions/context_extension.dart';
import 'package:hyll_ag/ui/common/device_type_scaffold.dart';
import 'package:hyll_ag/ui/common/icon_image.dart';
import 'package:hyll_ag/ui/common/network_error_try_again.dart';
import 'package:hyll_ag/ui/feed/home_feed_bloc.dart';
import 'package:hyll_ag/ui/feed/home_feed_bloc_state.dart';

class HomeFeedScreen extends StatelessWidget {
  static const String route = '/';

  const HomeFeedScreen();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeFeedBloc>();
    return DeviceTypeScaffold(
        widget: SafeArea(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        Expanded(child: BlocBuilder<HomeFeedBloc, HomeFeedBlocState>(builder: (_, state) {
          final homeFeedDataEvent = state.feedDataEvent;
          if (homeFeedDataEvent is Initial || homeFeedDataEvent is Loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (homeFeedDataEvent is Data) {
            final List<dynamic> homeFeeds = homeFeedDataEvent.data as List<dynamic>;
            return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, index) => homeFeeds[index + 1] is Feed ? const Divider(height: 15, thickness: 0.8) : const SizedBox(height: 15),
                itemBuilder: (_, index) {
                  final item = homeFeeds[index];
                  if (item is Feed) {
                    return _SingleHomeFeedItemWidget(feed: item);
                  } else if (item is PaginatedItem) {
                    return _PaginatedListItemWidget(paginatedItem: item, onProgressShowing: bloc.requestFeed);
                  } else {
                    return const _DoneListItemWidget();
                  }
                },
                itemCount: homeFeeds.length,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15));
          } else if(homeFeedDataEvent is Error) {
            return NetworkErrorTryAgain(onClick: bloc.requestFeed, margin: const EdgeInsetsDirectional.symmetric(horizontal: 20));
          }

          return const SizedBox();
        })),
        BlocBuilder<HomeFeedBloc, HomeFeedBlocState>(builder: (_, state) {
          final String bottomNetworkText = state.bottomNetworkText;
          if (bottomNetworkText.isEmpty) return const SizedBox();
          final theme = context.theme;
          return Container(
              alignment: Alignment.center,
              width: context.mediaSize.width,
              color: theme.colorScheme.error.withOpacity(0.75),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              child: Text(state.bottomNetworkText, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError)));
        })
      ]),
    ));
  }
}

class _SingleHomeFeedItemWidget extends StatelessWidget {
  final Feed feed;

  const _SingleHomeFeedItemWidget({required this.feed});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final firstContent = feed.contents.isNotEmpty ? feed.contents.first : null;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(feed.title, style: textTheme.bodyLarge),
          const SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
              IconImage(uri: feed.activityIcon, errorWidget: Icon(CupertinoIcons.map, size: 16, color: colorScheme.inverseSurface)),
              Text(feed.activity, style: textTheme.titleSmall)
            ]),
            const SizedBox(width: 15),
            Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(CupertinoIcons.location_solid, size: 16, color: colorScheme.inverseSurface),
              const SizedBox(width: 4),
              Expanded(child: Text('${feed.startingLocation?.name}', style: textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis))
            ]))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
            firstContent != null
                ? CachedNetworkImage(
                    imageUrl: firstContent.url.toString(),
                    imageBuilder: (_, imageProvider) => Container(
                        width: 140,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
                    errorWidget: (_, __, ___) => const Image(image: AssetImage('assets/default_content_image.webp'), width: 140, height: 90),
                    placeholder: (_, __) => const SizedBox(
                        width: 140,
                        height: 90,
                        child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator.adaptive(strokeWidth: 3)))))
                : const Image(image: AssetImage('assets/default_content_image.webp'), width: 140, height: 90),
            const SizedBox(width: 10),
            Expanded(
                child: GridView.count(
                    childAspectRatio: (1 / .2),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: feed.gridInfos.map((e) => _SingleGridInfoItemWidget(gridInfo: e)).toList())),
          ]),
          const SizedBox(height: 10),
          Text(feed.primaryDescription, style: textTheme.bodySmall)
        ]);
  }
}

class _SingleGridInfoItemWidget extends StatelessWidget {
  final GridInfo gridInfo;

  const _SingleGridInfoItemWidget({required this.gridInfo});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [IconImage(uri: gridInfo.iconUrl), const SizedBox(width: 4), Text(gridInfo.name, style: textTheme.titleSmall)],
    );
  }
}

class _PaginatedListItemWidget extends StatelessWidget {
  final PaginatedItem paginatedItem;
  final VoidCallback onProgressShowing;

  const _PaginatedListItemWidget({required this.paginatedItem, required this.onProgressShowing});

  @override
  Widget build(BuildContext context) {
    if (!paginatedItem.isShownOnce) {
      paginatedItem.isShownOnce = true;
      onProgressShowing.call();
    }
    return context.isHaveBottomNotch
        ? const Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator.adaptive(strokeWidth: 3))))
        : const Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator.adaptive(strokeWidth: 3))));
  }
}

class _DoneListItemWidget extends StatelessWidget {
  const _DoneListItemWidget();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            3,
            (index) => Container(
                margin: EdgeInsets.only(top: 10, right: 3, bottom: context.isHaveBottomNotch ? 35 : 10),
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.onSurface))));
  }
}
