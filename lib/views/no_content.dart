import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 65, 53, 67),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 64,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 32, right: 32, bottom: 16),
                  child: Text(
                    message,
                    textScaleFactor: 1.25,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
