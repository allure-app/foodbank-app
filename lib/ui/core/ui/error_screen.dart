import 'package:flutter/material.dart';
import 'package:foodbank_app/ui/core/ui/fb_gap.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required Error error,
    required Function() onReload,
  }) : _error = error, _onReload = onReload;

  final Error _error;
  final Function() _onReload;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;

    return Container(
      color: colours.errorContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_error.toString(), style: TextStyle(color: colours.error)),
            const FbGap(),
            ElevatedButton.icon(
              onPressed: _onReload,
              label: Text('Reload'),
              icon: Icon(Icons.refresh),
              style: ElevatedButton.styleFrom(
                backgroundColor: colours.error,
                foregroundColor: colours.onError,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
