import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';

class SectionSkills extends StatelessWidget {
  const SectionSkills({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final px = isMobile ? 24.0 : 80.0;
    return Container(
      color: const Color(0xFF060608),
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: TextSpan(children: [
          TextSpan(text: 'My ', style: GoogleFonts.inter(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
          TextSpan(text: 'Skills', style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6), fontSize: 36, fontWeight: FontWeight.w800)),
        ])),
        const SizedBox(height: 8),
        Text('Technologies and tools I use to bring ideas to life',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 15),
            textAlign: TextAlign.center),
        const SizedBox(height: 60),
        Wrap(
          spacing: 32, runSpacing: 40,
          alignment: WrapAlignment.center,
          children: kSkills.asMap().entries
              .map((e) => _SkillRing(skill: e.value, delay: e.key * 100))
              .toList(),
        ),
      ]),
    );
  }
}

class _SkillRing extends StatefulWidget {
  final Skill skill; final int delay;
  const _SkillRing({required this.skill, required this.delay});
  @override State<_SkillRing> createState() => _SkillRingState();
}

class _SkillRingState extends State<_SkillRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 1200));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(Duration(milliseconds: widget.delay + 300),
        () { if (mounted) _ctrl.forward(); });
  }

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  IconData _icon() {
    switch (widget.skill.name) {
      case 'Flutter':       return Icons.phone_android_rounded;
      case 'Dart':          return Icons.layers_rounded;
      case 'Firebase':      return Icons.storage_rounded;
      case 'UI/UX Design':  return Icons.palette_rounded;
      case 'REST APIs':     return Icons.public_rounded;
      case 'Git & GitHub':  return Icons.code_rounded;
      default:              return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    const size = 130.0; const sw = 8.0;
    return SizedBox(
      width: size,
      child: Column(children: [
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => CustomPaint(
            painter: _Ring(progress: _anim.value * widget.skill.value, sw: sw),
            child: SizedBox(width: size, height: size,
              child: Center(child: Container(
                width: size - sw * 2 - 20,
                height: size - sw * 2 - 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF111827)),
                child: Icon(_icon(), size: 38, color: Colors.white54),
              ))),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Text(
            '${(_anim.value * widget.skill.percent).toInt()}%',
            style: GoogleFonts.inter(color: const Color(0xFF3B82F6),
                fontSize: 22, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 4),
        Text(widget.skill.name,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
            textAlign: TextAlign.center),
      ]),
    );
  }
}

class _Ring extends CustomPainter {
  final double progress, sw;
  _Ring({required this.progress, required this.sw});
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = (size.width - sw) / 2;
    canvas.drawCircle(c, r, Paint()
      ..color = const Color(0xFF1F2937)
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw);
    if (progress > 0)
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r), -pi / 2, 2 * pi * progress, false,
        Paint()
          ..shader = const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)])
              .createShader(Rect.fromCircle(center: c, radius: r))
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..strokeCap = StrokeCap.round,
      );
  }
  @override bool shouldRepaint(_Ring o) => o.progress != progress;
}
