
////////////////////////////// WIDGET TESTING //////////////////////////////
// Widget testing is a unique tool that flutter provies to check if widgets 
// are acting as expected. It is similar to unit testing, but focuses on
// UI. Essentially it checks if certian text, buttons, and input fields
// are where they are suppose to be.

////////////////////////////// HOW TO TEST //////////////////////////////
// type in terminal: flutter test
// This command will run through the pages to see if the predefined widgets are correct.
// You can also run these tests without having to run the emulator.
// These tests will also be run before launching your app if you are using an emulator

////////////////////////////// HOW TO READ TESTS //////////////////////////////
// If all tests pass you will see: All tests passed!
// Otherwise you will see which tests failed and see which line number failed
// You can think of each of the tests as checking to see if everything is where it is 
// suppose to be. Each tests contains multiple checks pertaining to each page.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_grab/main.dart';
import 'package:book_grab/Models/user.dart';
import 'package:book_grab/screens/home/home.dart';

void main() {
  testWidgets('Login Page - Presets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // find headers
    expect(find.text('Book Grab'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    // find icons
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    // find text input fields for password and email
    expect(find.widgetWithText(TextFormField, 'password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'email'), findsOneWidget);
    // find buttons
    expect(find.byType(RaisedButton), findsNWidgets(2)); // two buttons: Login && Register
    // check button works
    RaisedButton button = find.widgetWithText(RaisedButton, 'Register').evaluate().first.widget;
    button.onPressed();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Register'), findsOneWidget); 
  });

  testWidgets('Login Page - Login Input', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // recheck in login - find headers
    expect(find.text('Book Grab'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    // find buttons
    expect(find.byType(RaisedButton), findsNWidgets(2)); // two buttons
    expect(find.widgetWithText(RaisedButton, 'Login'), findsOneWidget); // login
    expect(find.widgetWithText(RaisedButton, 'Register'), findsOneWidget); // register
    // check if input fields work
    await tester.enterText(find.widgetWithText(TextFormField, 'email'), 'test@mail.csuchico.edu');
    expect(find.text('test@mail.csuchico.edu'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'password'), '123456');
    expect(find.text('123456'), findsOneWidget);
  });

  testWidgets('Register Page - Presets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(), );
    // click register page from login
    RaisedButton button = find.widgetWithText(RaisedButton, 'Register').evaluate().first.widget;
    button.onPressed();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Book Grab'), findsNothing); // not in login page
    // find headers
    expect(find.text('Register'), findsOneWidget);
    // find icons
    expect(find.byIcon(Icons.person), findsOneWidget); // sign in button
    // find buttons
    expect(find.byType(RaisedButton), findsOneWidget); // one button
    // check if input fields work
    await tester.enterText(find.widgetWithText(TextFormField, 'email@mail.school.edu'),
     'test@mail.csuchico.edu');
    expect(find.text('test@mail.csuchico.edu'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'password (8 or more characters)'),
     '12345678');
    expect(find.text('12345678'), findsOneWidget);
  });
  testWidgets('Home Page - Title ', (WidgetTester tester) async{
    User testUser = User(uid: "1234", email: "fake@mail.csuchico.edu" );
    await tester.pumpWidget(Home(user: testUser));
    expect(find.text('Book Grab'), findsOneWidget);
    expect(find.text('Register'), findsNothing);

  });
}