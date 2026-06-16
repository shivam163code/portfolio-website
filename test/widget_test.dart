import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    // Set screen size to a tablet view to prevent layout overflows
    tester.view.physicalSize = const Size(1000, 1000);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.runAsync(() async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
    });
    expect(find.byType(PortfolioApp), findsOneWidget);
  });
}
