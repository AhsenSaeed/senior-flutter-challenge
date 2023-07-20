import 'package:equatable/equatable.dart';
import 'package:hyll_ag/data/meta_data.dart';

class HomeFeedBlocState extends Equatable {
  final DataEvent feedDataEvent;
  final String bottomNetworkText;

  const HomeFeedBlocState({required this.feedDataEvent, required this.bottomNetworkText});

  const HomeFeedBlocState.initial() : this(feedDataEvent: const Initial(), bottomNetworkText: '');

  HomeFeedBlocState copyWith({DataEvent? feedDataEvent, String? bottomNetworkText}) =>
      HomeFeedBlocState(feedDataEvent: feedDataEvent ?? this.feedDataEvent, bottomNetworkText: bottomNetworkText ?? this.bottomNetworkText);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [feedDataEvent, bottomNetworkText];
}
