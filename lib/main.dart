import 'package:anime_watchlist_app/Widgets/validation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'firbase/firebase_options.dart';
import 'view/login_page.dart';
import 'bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import './Anilist_GraphQL/anilist_Oauth.dart';
import 'package:hive/hive.dart';

//Main function to run the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co',
  );
  final AuthLink authLink = AuthLink(getToken: () async {
    return 'Bearer ' + await AnlistAuth.getAccessToken();
  });
  final Link link = authLink.concat(httpLink);

  final Box userBox = await Hive.openBox('user'); // Open the box
  final ValueNotifier<GraphQLClient> client =
      ValueNotifier<GraphQLClient>(GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  ));

  runApp(AnimeWatchlistApp(client: client));
}

//Main class for the app
class AnimeWatchlistApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  AnimeWatchlistApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
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
