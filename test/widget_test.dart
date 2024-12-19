import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_book/appointments/appointments.dart';
import 'package:flutter_book/appointments/appointmentsEntry.dart';
import 'package:flutter_book/contacts/contacts.dart';
import 'package:flutter_book/notes/notes.dart';
import 'package:flutter_book/tasks/tasks.dart';


void main() {
  testWidgets('Check if Appointments screen is shown', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Appointments()));
    await tester.pumpAndSettle();

    expect(find.text('Appointments'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Navigate from Appointments to Contacts screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Appointments()));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.pumpWidget(MaterialApp(home: Contacts()));

    expect(find.text('Contacts'), findsOneWidget);
  });

  testWidgets('Navigate between Contacts and Notes screens', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Contacts()));
    await tester.pumpAndSettle();

    expect(find.text('Contacts'), findsOneWidget);

    await tester.pumpWidget(MaterialApp(home: Notes()));
    await tester.pumpAndSettle();

    expect(find.text('Notes'), findsOneWidget);
  });

  testWidgets('Check if Tasks screen shows the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Tasks()));
    await tester.pumpAndSettle();

    expect(find.text('Tasks'), findsOneWidget);
  });

  testWidgets('Floating action button on Appointments screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Appointments()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AppointmentsEntry), findsOneWidget);
  });

  testWidgets('Verify Contacts screen shows correct content', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: Contacts()));
    await tester.pumpAndSettle();

    expect(find.text('Contacts'), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
