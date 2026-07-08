import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/section_hero.dart';
import '../widgets/section_about.dart';
import '../widgets/section_skills.dart';
import '../widgets/section_services.dart';
import '../widgets/section_projects.dart';
import '../widgets/section_contact.dart';
import '../widgets/footer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scroll = ScrollController();
  final _keys   = List<GlobalKey>.generate(6, (_) => GlobalKey());
  int  _active  = 0;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final show = _scroll.offset > 400;
      if (show != _showFab) setState(() => _showFab = show);
    });
  }

  void _goto(int i) {
    final ctx = _keys[i].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut);
    setState(() => _active = i);
  }

  @override
  void dispose() { _scroll.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: _showFab
          ? FloatingActionButton(
              mini: true,
              backgroundColor: const Color(0xFF3B82F6),
              onPressed: () => _goto(0),
              child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white),
            )
          : null,
      body: Stack(children: [
        SingleChildScrollView(
          controller: _scroll,
          physics: const ClampingScrollPhysics(),
          child: Column(children: [
            const SizedBox(height: 64),
            SectionHero   (key: _keys[0], onContact: () => _goto(5)),
            SectionAbout  (key: _keys[1]),
            SectionSkills (key: _keys[2]),
            SectionServices(key: _keys[3]),
            SectionProjects(key: _keys[4]),
            SectionContact (key: _keys[5]),
            const FooterWidget(),
          ]),
        ),
        NavBar(active: _active, onTap: _goto),
      ]),
    );
  }
}
