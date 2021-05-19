import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/home/movie.dart';
import 'package:flutter_app/home/movie_service.dart';
// ignore: deprecated_member_use
import 'package:flutter_riverpod/all.dart';

import 'movies_exception.dart';

final movieFutureProvider = FutureProvider.autoDispose<List<Movie>>((ref) async{
  ref.maintainState = true;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Cinema'),
      ),
      body: watch(movieFutureProvider).when(
        error: (e, s) {
          if(e is MoviesException) {
            return _ErrorBody(message: e.message);
          }
          print(e.toString());
          print(s.toString());
          return _ErrorBody(message:'Oops,Something unexpected happened');
        },
    loading: () => Center(child: CircularProgressIndicator()),
    data: (movies) {
          return RefreshIndicator(
          onRefresh: (){
            return context.refresh(movieFutureProvider);
          },
              child:GridView.extent(
          maxCrossAxisExtent:200,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
          children: movies.map((movie) => _MovieBox(movie: movie)).toList(),
          ),
          );
          },
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget{
  const _ErrorBody({
    Key key,
    @required this.message,
}) :assert(message != null,'A non-null string must be provided'),
  super(key: key);

  final String message;

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
              onPressed: () => context.refresh(movieFutureProvider),
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}

class _MovieBox extends StatelessWidget{
  final Movie movie;

  const _MovieBox({
    Key key, this.movie})
  :super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: (){
          // MaterialPageRoute(builder: );
          },
        child:Stack(
      children: [
        Image.network(
          movie.fullImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _FrontBanner(text:movie.title),
        ),
      ],
    ));
  }
}

class _FrontBanner extends StatelessWidget{
  const _FrontBanner({
    Key key,
    @required this.text,
}) :super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX:10.0,sigmaY:10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 60,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}