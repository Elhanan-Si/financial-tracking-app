import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/features/auth_lock/presentation/screens/lock_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('LockScreen renders correctly and shows initial PIN setup', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: LockScreen(),
            ),
          ),
        ),
      );
      // Allow async AuthController._init() to complete
      await Future.delayed(const Duration(milliseconds: 100));
    });

    await tester.pumpAndSettle();

    expect(find.text('הגדרת קוד PIN ראשוני'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
