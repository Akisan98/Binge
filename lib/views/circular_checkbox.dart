import 'dart:developer';

import 'package:flutter/material.dart';

typedef CheckboxCallback = void Function(int seen);

class CircularCheckbox extends StatefulWidget {
  CircularCheckbox({Key? key, required this.seen, required this.onChanged})
      : super(key: key);

  int seen;
  final CheckboxCallback onChanged;

  @override
  State<CircularCheckbox> createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  @override
  Widget build(BuildContext context) {
    log('CircularCheckbox - Build');

    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
        activeColor: Theme.of(context).primaryColor,
        value: widget.seen == 1,
        shape: const CircleBorder(),
        onChanged: (nbool) {
          setState(() {
            widget.seen = nbool ?? false ? 1 : 0;
            widget.onChanged(nbool ?? false ? 1 : 0);
          });
        },
      ),
    );
  }
}
