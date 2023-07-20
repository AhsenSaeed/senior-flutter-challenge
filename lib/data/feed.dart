class HomeFeed {
  final int count;
  final String? next;
  final List<Feed> feeds;

  HomeFeed({required this.count, required this.next, required this.feeds});

  factory HomeFeed.fromJson(Map<String, dynamic> json) {
    final int count = json.containsKey('count') ? json['count'] : -1;
    final String? next = json.containsKey('next') ? json['next'] : null;
    final List<Feed> feeds = json.containsKey('data') ? (json['data'] as List<dynamic>).map((e) => Feed.fromJson(e)).toList() : [];

    return HomeFeed(count: count, next: next, feeds: feeds);
  }

  @override
  String toString() {
    return 'HomeFeed{count: $count, next: $next, feeds: $feeds}';
  }
}

class Feed {
  final int id;
  final bool isLive;
  final String title;
  final Location? areaLocation;
  final Location? startingLocation;
  final List<String> tags;
  final String activity;
  final int activityId;
  final String primaryImage;
  final String primaryVideo;
  final String thumbnail;
  final Uri activityIcon;
  final List<Badge> badges;
  final int bucketListCount;
  final List<Content> contents;
  final SupplyInfo? supplyInfo;
  final List<GridInfo> gridInfos;
  final bool isTicketOptional;
  final String primaryDescription;
  final String description;
  final List<Fact> facts;

  Feed(
      {required this.id,
      required this.isLive,
      required this.title,
      required this.areaLocation,
      required this.startingLocation,
      required this.tags,
      required this.activity,
      required this.activityId,
      required this.primaryImage,
      required this.primaryVideo,
      required this.thumbnail,
      required this.activityIcon,
      required this.badges,
      required this.bucketListCount,
      required this.contents,
      required this.supplyInfo,
      required this.gridInfos,
      required this.isTicketOptional,
      required this.primaryDescription,
      required this.description,
      required this.facts});

  factory Feed.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : -1;
    final String status = json.containsKey('status') ? json['status'] : 'live';
    final bool isLive = status == 'live';
    final String title = json.containsKey('title') ? json['title'] : '';
    final Location areaLocation = json.containsKey('area_location') ? Location.fromJson(json['area_location']) : Location.fromJson({});
    final Location startingLocation = json.containsKey('starting_location') ? Location.fromJson(json['starting_location']) : Location.fromJson({});
    final List<String> tags = json.containsKey('tags') ? (json['tags'] as List<dynamic>).map((e) => e.toString()).toList() : <String>[];
    final String activity = json.containsKey('activity') ? json['activity'] : '';
    final int activityId = json.containsKey('activity_id') ? json['activity_id'] : -1;
    final String primaryImage = json.containsKey('primary_image') ? json['primary_image'] : '';
    final String primaryVideo = json.containsKey('primary_video') ? json['primary_video'] : '';
    final String thumbnail = json.containsKey('thumbnail') ? json['thumbnail'] : '';

    final String activityIconLink = json.containsKey('activity_icon') ? json['activity_icon'] : '';
    final Uri activityIcon = Uri.parse(activityIconLink);

    final List<Badge> badges =
        json.containsKey('badges') ? (json['badges'] as List<dynamic>).map((e) => Badge.fromServerJson(e)).toList() : <Badge>[];
    final int bucketListCount = json.containsKey('bucket_list_count') ? json['bucket_list_count'] : -1;
    final List<Content> contents =
        json.containsKey('contents') ? (json['contents'] as List<dynamic>).map((e) => Content.fromJson(e)).toList() : <Content>[];
    final SupplyInfo? supplyInfo = json.containsKey('supply_info')
        ? json['supply_info'] != null
            ? SupplyInfo.fromJson(json['supply_info'])
            : null
        : null;
    final List<GridInfo> gridInfos =
        json.containsKey('grid_info') ? (json['grid_info'] as List<dynamic>).map((e) => GridInfo.fromServerJson(e)).toList() : <GridInfo>[];
    final bool isTicketOptional = json.containsKey('ticket_optional') ? json['ticket_optional'] : false;
    final String primaryDescription = json.containsKey('primary_description') ? json['primary_description'] : '';
    final String description = json.containsKey('description') ? json['description'] : '';
    final List<Fact> facts = json.containsKey('facts') ? (json['facts'] as List<dynamic>).map((e) => Fact.fromServerJson(e)).toList() : <Fact>[];

    return Feed(
        id: id,
        isLive: isLive,
        title: title,
        areaLocation: areaLocation,
        startingLocation: startingLocation,
        tags: tags,
        activity: activity,
        activityId: activityId,
        primaryImage: primaryImage,
        primaryVideo: primaryVideo,
        thumbnail: thumbnail,
        activityIcon: activityIcon,
        badges: badges,
        bucketListCount: bucketListCount,
        contents: contents,
        supplyInfo: supplyInfo,
        gridInfos: gridInfos,
        isTicketOptional: isTicketOptional,
        primaryDescription: primaryDescription,
        description: description,
        facts: facts);
  }

  @override
  String toString() {
    return 'Feed{id: $id, isLive: $isLive, title: $title, areaLocation: $areaLocation, startingLocation: $startingLocation, tags: $tags, activity: $activity, activityId: $activityId, primaryImage: $primaryImage, primaryVideo: $primaryVideo, thumbnail: $thumbnail, activityIcon: $activityIcon, badges: $badges, bucketListCount: $bucketListCount, contents: $contents, supplyInfo: $supplyInfo, gridInfos: $gridInfos, isTicketOptional: $isTicketOptional, primaryDescription: $primaryDescription, description: $description, facts: $facts}';
  }
}

class Location {
  final String name;
  final String? imageUrl;

  Location({required this.name, this.imageUrl});

  factory Location.fromJson(Map<String, dynamic> json) {
    final String name = json.containsKey('name') ? json['name'] : '';
    final String? imageUrl = json.containsKey('image_url') ? json['image_url'] : null;

    return Location(name: name, imageUrl: imageUrl);
  }

  @override
  String toString() {
    return 'Location{name: $name, imageUrl: $imageUrl}';
  }
}

class Badge {
  final String title;
  final Uri icon;
  final String colorScheme;

  Badge({required this.title, required this.icon, required this.colorScheme});

  factory Badge.fromServerJson(Map<String, dynamic> json) {
    final String title = json.containsKey('title') ? json['title'] : '';
    final String iconLink = json.containsKey('icon') ? json['icon'] : '';
    final Uri icon = Uri.parse(iconLink);

    final String colorScheme = json.containsKey('color_scheme') ? json['color_scheme'] : '';

    return Badge(title: title, icon: icon, colorScheme: colorScheme);
  }

  @override
  String toString() {
    return 'Badge{title: $title, icon: $icon, colorScheme: $colorScheme}';
  }
}

class Content {
  final String id;
  final ContentType type;
  final String mode;
  final Uri url;
  final ContentSource? source;
  final bool isPrivate;

  Content({required this.id, required this.type, required this.mode, required this.url, this.source, required this.isPrivate});

  factory Content.fromJson(Map<String, dynamic> json) {
    final String id = json.containsKey('id') ? json['id'] : '';
    final String contentType = json.containsKey('content_type') ? json['content_type'] : '';
    final ContentType type = contentType.contentType;
    final String mode = json.containsKey('content_mode') ? json['content_mode'] : '';
    final String contentUrl = json.containsKey('content_url') ? json['content_url'] : '';
    final Uri url = Uri.parse(contentUrl);
    final ContentSource? source = json.containsKey('content_source')
        ? json['content_source'] != null
            ? ContentSource.fromServerJson(json['content_source'])
            : null
        : null;
    final bool isPrivate = json.containsKey('is_private') ? json['is_private'] : false;

    return Content(id: id, type: type, mode: mode, url: url, isPrivate: isPrivate, source: source);
  }

  @override
  String toString() {
    return 'Content{id: $id, type: $type, mode: $mode, url: $url, source: $source, isPrivate: $isPrivate}';
  }
}

enum ContentType { image, video }

extension ContentTypeExtension on String {
  ContentType get contentType {
    switch (toLowerCase()) {
      case 'video':
        return ContentType.video;
      default:
        return ContentType.image;
    }
  }
}

class ContentSource {
  final String id;
  final String? title;
  final String? name;
  final String? icon;

  ContentSource({required this.id, required this.title, this.name, this.icon});

  factory ContentSource.fromServerJson(Map<String, dynamic> json) {
    final String id = json.containsKey('id') ? json['id'] : '';
    final String? title = json.containsKey('title') ? json['title'] : null;
    final String? name = json.containsKey('name') ? json['name'] : '';
    final String? icon = json.containsKey('icon') ? json['icon'] : '';

    return ContentSource(id: id, title: title, name: name, icon: icon);
  }

  @override
  String toString() {
    return 'ContentSource{id: $id, title: $title, name: $name, icon: $icon}';
  }
}

class SupplyInfo {
  final String? name;
  final String priceTitle;
  final String? priceSubtitle;
  final String buttonType;
  final Uri? link;

  SupplyInfo({this.name, required this.priceTitle, this.priceSubtitle, required this.buttonType, this.link});

  factory SupplyInfo.fromJson(Map<String, dynamic> json) {
    final String? name = json.containsKey('supplier_name') ? json['supplier_name'] : null;
    final String priceTitle = json.containsKey('price_title') ? json['price_title'] : '';
    final String? priceSubtitle = json.containsKey('price_subtitle') ? json['price_subtitle'] : null;
    final String buttonType = json.containsKey('button_type') ? json['button_type'] : '';
    final String? supplierLink = json.containsKey('link') ? json['link'] : null;
    final Uri link = Uri.parse(supplierLink ?? '');

    return SupplyInfo(priceTitle: priceTitle, buttonType: buttonType, name: name, priceSubtitle: priceSubtitle, link: link);
  }

  @override
  String toString() {
    return 'SupplyInfo{name: $name, priceTitle: $priceTitle, priceSubtitle: $priceSubtitle, buttonType: $buttonType, link: $link}';
  }
}

class GridInfo {
  final String name;
  final String value;
  final Uri iconUrl;
  final String? schema;

  GridInfo({required this.name, required this.value, required this.iconUrl, this.schema});

  factory GridInfo.fromServerJson(Map<String, dynamic> json) {
    final String name = json.containsKey('name') ? json['name'] : '';
    final String value = json.containsKey('value') ? json['value'] : '';
    final String iconLink = json.containsKey('icon_url') ? json['icon_url'] : '';
    final Uri iconUrl = Uri.parse(iconLink);
    final String? schema = json.containsKey('schema') ? json['schema'] : null;

    return GridInfo(name: name, value: value, iconUrl: iconUrl, schema: schema);
  }

  @override
  String toString() {
    return 'GridInfo{name: $name, value: $value, iconUrl: $iconUrl, schema: $schema}';
  }
}

class Fact {
  final String name;
  final String value;
  final String? unit;
  final Uri iconUrl;
  final String displaySection;
  final int definitionId;
  final int adventureFactId;

  Fact(
      {required this.name,
      required this.value,
      required this.unit,
      required this.iconUrl,
      required this.displaySection,
      required this.definitionId,
      required this.adventureFactId});

  factory Fact.fromServerJson(Map<String, dynamic> json) {
    final String name = json.containsKey('name') ? json['name'] : '';
    final String value = json.containsKey('value') ? json['value'] : '';
    final String? unit = json.containsKey('unit') ? json['unit'] : null;
    final String iconUrlLink = json.containsKey('icon_url') ? json['icon_url'] : '';
    final Uri iconUrl = Uri.parse(iconUrlLink);

    final String displaySection = json.containsKey('display_section') ? json['display_section'] : '';
    final int definitionId = json.containsKey('fact_definition_id') ? json['fact_definition_id'] : -1;
    final int adventureFactId = json.containsKey('adventure_fact_id') ? json['adventure_fact_id'] : -1;

    return Fact(
        name: name,
        value: value,
        unit: unit,
        iconUrl: iconUrl,
        displaySection: displaySection,
        definitionId: definitionId,
        adventureFactId: adventureFactId);
  }

  @override
  String toString() {
    return 'Fact{name: $name, value: $value, unit: $unit, iconUrl: $iconUrl, displaySection: $displaySection, definitionId: $definitionId, adventureFactId: $adventureFactId}';
  }
}
