import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:newapp/sevices/database/create_database.dart';

import '../../../models/post_model/post_model.dart';

part 'read_news_event.dart';
part 'read_news_state.dart';

class ReadNewsBloc extends Bloc<ReadNewsEvent, ReadNewsState> {
  ReadNewsBloc() : super(ReadNewsLoading()) {
    on<ReadNewsEvent>((event, emit) async{
      if(event is AddReadNews){
        emit(ReadNewsLoading());

        try{
          List<PostModel> posts =  await MyDatabase().readPostFromDb();
          emit(ReadNewsLoaded(posts));
        }catch(e){
          emit(ReadNewsFailed(e));
        }
      }
    });
  }
}
