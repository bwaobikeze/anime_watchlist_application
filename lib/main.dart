import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'firbase/firebase_options.dart';
import 'view/login_page.dart';
import './Anilist_GraphQL/anilist_Oauth.dart';
import './Repositories/sharedPreferences.dart';

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

  final ValueNotifier<GraphQLClient> client =
      ValueNotifier<GraphQLClient>(GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  ));
  await AppSharedPreferences.init();
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
        home: LoginWithAnilist(client: client),
      ),
    );
  }
}
