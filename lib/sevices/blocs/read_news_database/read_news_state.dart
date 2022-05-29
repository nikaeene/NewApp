part of 'read_news_bloc.dart';

@immutable
abstract class ReadNewsState {}

class ReadNewsLoading extends ReadNewsState {}

class ReadNewsLoaded extends ReadNewsState {
  List<PostModel> posts;
  ReadNewsLoaded(this.posts);
}

class ReadNewsFailed extends ReadNewsState {
  final e;
  ReadNewsFailed(this.e);
}
