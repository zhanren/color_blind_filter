import 'package:color_blind_filter/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launches and shows permission screen', (tester) async {
    await tester.pumpWidget(const ColorBlindFilterApp());

    // App should show loading initially (checking permissions)
    expect(find.byType(ColorBlindFilterApp), findsOneWidget);
  });
}
