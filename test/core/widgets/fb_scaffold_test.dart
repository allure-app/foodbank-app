import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodbank_app/core/widgets/fb_scaffold.dart';

void main() {
  testWidgets('Scaffold title is set', (WidgetTester tester) async {
    // Arrange.
    final widget = const FbScaffold(title: 'Test Title', body: Placeholder());

    // Act.
    await tester.pumpWidget(MaterialApp(home: widget));

    // Assert.
    expect(find.text('Test Title'), findsOneWidget);
  });
}
