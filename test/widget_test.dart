import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ispy/app/app.dart';
import 'package:ispy/auth/auth_page.dart';

void main() {
  testWidgets('MyApp Widget Tests', (WidgetTester tester) async {
    expect(const MyApp(), isA<StatelessWidget>());

    await tester.pumpWidget(const MyApp());

    final getMaterialApp = find.byType(GetMaterialApp);
    final homeIsAuth = find.byType(AuthPage);

    expect(getMaterialApp, findsOneWidget);
    expect(homeIsAuth, findsOneWidget);
  });

  testWidgets('AuthPage Widget Tests', (WidgetTester tester) async {
    expect(const AuthPage(), isA<StatelessWidget>());
    expect(const GoogleSignInButton(), isA<StatefulWidget>());

    await tester.pumpWidget(const GetMaterialApp(home: AuthPage()));

    final textWidgets = find.byType(Text);
    final columnWidgets = find.byType(Column);
    final appTitle = find.text('iSpy');

    expect(textWidgets, findsOneWidget);
    expect(appTitle, findsOneWidget);
    expect(columnWidgets, findsNWidgets(2));

    // Google Sign In Button Widget Tests
    await tester.pumpWidget(const GetMaterialApp(home: GoogleSignInButton()));

    final signInButton = find.byType(OutlinedButton);
    final buttonText = find.text('Sign in with Google');
    expect(signInButton, findsOneWidget);
    expect(buttonText, findsOneWidget);
  });
}
