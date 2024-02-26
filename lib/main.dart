import 'package:anime_watchlist_app/repositories/validation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'firebase_options.dart';
import 'view/login_page.dart';
import 'bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './repositories/aniList_API_data.dart';
import 'package:graphql/client.dart';

//Main function to run the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AnimeWatchlistApp());
}

//Main class for the app
class AnimeWatchlistApp extends StatelessWidget {
  const AnimeWatchlistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: AniListAPI.client,
      child: MaterialApp(
        title: 'Anime Watchlist',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
