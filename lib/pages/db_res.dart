import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../views/db_content.dart';
import '../views/my_app_bar.dart';
import '../views/no_content.dart';

class DBRes extends StatelessWidget {
  const DBRes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: SizedBox.expand(
          child: ValueListenableBuilder<Box<MediaContent>>(
            valueListenable: Hive.box<MediaContent>('myBox').listenable(),
            builder: (context, box, widget) {
              var items = box.values.where((element) {
                if (element.type == MediaType.movie) {
                  if (element.notificationOnly ?? false) {
                    return true;
                  }
                  return false;
                }

                if (element.nextToWatch != null &&
                    element.nextToWatch?.airDate != null &&
                    element.nextToWatch?.airDate != '') {
                  final date = DateTime.parse(
                      element.nextToWatch?.airDate ?? '2099-01-01');
                  return DateTime.now().difference(date).inDays > 0;
                }

                return false;
              }).toList();

              // ignore: cascade_invocations
              items.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));

              // items.add(MediaContent());

              log('Items: ${items.length}');

              List<Widget> cards = [];

              for (var i = 0; i < items.length; i++) {
                cards.add(SizedBox(
                  height: 170,
                  child: DBContent(
                    item: items.elementAt(i), //box.getAt(index),
                    index: i,
                  ),
                ));
              }

              cards.insert(
                  0,
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: MyAppBar(title: 'Home'),
                  ));

              return cards.length > 1
                  ? ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) => cards[index])
                  : Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: const MyAppBar(
                            title: 'Home',
                          ),
                        ),
                        NoContent(
                            message:
                                'You are all up to date, how about starting a new show or movie?')
                      ],
                    );
            },
          ),
        ),
      );
}
