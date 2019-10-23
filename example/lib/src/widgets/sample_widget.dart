import 'package:flutter/material.dart';
import 'package:example/src/i10n/app_localizations.dart';

class SampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text(loc.registerButton),
      ),
    );
  }
}
