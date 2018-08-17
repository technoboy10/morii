import 'dart:async';
import 'package:flutter/material.dart';

import 'package:morii/models/Status.dart';
import 'package:morii/components/FeedImage.dart';


class Timeline extends StatelessWidget {
  /*
   * TODO: Should Timeline take a future list of posts or just a list of posts?
   * It feels a little icky to do future management in what should be a 
   * fairly display-based component.
   */

  final Future<List<Status>> statuses;

  Timeline({this.statuses});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Status>>(
          future: statuses,
          builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsetsDirectional.only(bottom: 64.0, top: 24.0), // To prevent weirdness with the bottom bar and transparent status bar
                  children: snapshot.data.map((status) {
                    // Create a FeedImage widget for every status in the snapshot
                    return FeedImage(status: status);
                  }).toList()
                );
              } else if (snapshot.hasError) {
                // TODO: handle errors in a more user-friendly way
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator(); 
            },
        );
  }
}