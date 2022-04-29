import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../views/db_content.dart';

class DBRes extends StatelessWidget {
  const DBRes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
          child: SizedBox.expand(
        child: ValueListenableBuilder<Box<MediaContent>>(
          valueListenable: Hive.box<MediaContent>('myBox').listenable(),
          builder: (context, box, widget) => ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            itemCount: box
                //.values.where((element) => element.type == MediaType.movie)
                .length,
            itemBuilder: (context, index) => SizedBox(
              height: 170,
              child: DBContent(
                item: box.getAt(index),
                //.values
                //.where((element) => element.type == MediaType.movie)
                //.elementAt(index),
                index: index,
              ),
            ),
          ),
        ),
      ));
}
