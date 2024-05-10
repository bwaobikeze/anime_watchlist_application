import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';
import '../models/Current_Anlist_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './sharedPreferences.dart';

void checkUserCredentials(GraphQLClient clientForCheck) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final QueryOptions userQuery =
      QueryOptions(document: gql(getCurrentUserQuery));

  final QueryResult result = await clientForCheck.query(userQuery);
  final Map<String, dynamic> user = result.data?['Viewer'] ?? {};
  currentUser authUser = currentUser.fromJson(user);
  try {
    DocumentSnapshot userSnapshot =
        await users.doc(authUser.id.toString()).get();

    if (userSnapshot.id == authUser.id.toString()) {
      AppSharedPreferences.instance.setInt('Userid', authUser.id);
      AppSharedPreferences.instance.setString('AvatarUrl', authUser.avatar);
      AppSharedPreferences.instance.setString('UserName', authUser.name);
      print(AppSharedPreferences.instance.getString('AvatarUrl'));
    } else {
      print('user not found');
    }
  } catch (e) {
    print('Error reading data: $e');
  }
}
