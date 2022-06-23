import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  const AdaptiveFlatButton(this.label, this.onPressed, {Key? key})
      : super(key: key);

  @override
  build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            ),
          )
        : CupertinoButton(child: Text(label), onPressed: onPressed);
  }
}
