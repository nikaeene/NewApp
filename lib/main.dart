import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:newapp/repositories/api_calling/new_api_call/fetch_posts.dart';
import 'package:newapp/sevices/blocs/read_news_database/read_news_bloc.dart';
import 'package:newapp/sevices/database/create_database.dart';

import 'models/post_model/post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NewsApp', style: Theme.of(context).textTheme.headline4,),),
      body: BlocProvider<ReadNewsBloc>(
        create: (context) =>
        ReadNewsBloc()
          ..add(AddReadNews()),
        child: BlocBuilder<ReadNewsBloc, ReadNewsState>(
          builder: (context, state) {
            if(state is ReadNewsLoading){
              return const Center(child: CircularProgressIndicator(),);
            }if(state is ReadNewsFailed){
              return Center(child: Text('Fetching the data Failed because: ${state.e}'),);
            }if(state is ReadNewsLoaded)
            return Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height/6,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 2,
                    color: Colors.white70,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(child: Text(state.posts[index].title, style: Theme.of(context).textTheme.headline6, textDirection: TextDirection.rtl,),)),
                          SizedBox(height: 10,),
                          Expanded(
                            flex: 5,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: HtmlWidget(state.posts[index].excerpt,))))
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
              return Center(child: Text('Please load the data!', style: Theme.of(context).textTheme.headline2));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<PostModel> posts = await FetchPosts().getPosts();
          print('fetchData: $posts');

          bool result = await MyDatabase().insertPosts(posts);
          print('result: $result');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
