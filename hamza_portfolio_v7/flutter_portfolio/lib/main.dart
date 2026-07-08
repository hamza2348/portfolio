import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() => runApp(const App());

// Hides ALL scrollbars (vertical + horizontal)
class _NoScrollbar extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext ctx, Widget child, ScrollableDetails d) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamza Sattar | Flutter Developer',
      debugShowCheckedModeBanner: false,
      scrollBehavior: _NoScrollbar(),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
