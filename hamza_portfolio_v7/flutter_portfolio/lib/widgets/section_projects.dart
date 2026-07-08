import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../utils/launcher.dart';

class SectionProjects extends StatelessWidget {
  const SectionProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final px = isMobile ? 24.0 : 80.0;
    return Container(
      color: const Color(0xFF060608),
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: TextSpan(children: [
          TextSpan(text: 'My ', style: GoogleFonts.inter(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
          TextSpan(text: 'Projects', style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6), fontSize: 36, fontWeight: FontWeight.w800)),
        ])),
        const SizedBox(height: 8),
        Text('Showcasing some of my recent Flutter development work',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 15),
            textAlign: TextAlign.center),
        const SizedBox(height: 60),
        ...kProjects.asMap().entries.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 48),
          child: _ProjectRow(p: e.value, isMobile: isMobile),
        )),
      ]),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project p; final bool isMobile;
  const _ProjectRow({required this.p, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final img  = _ImageBox(p: p);
    final info = _InfoBox(p: p);
    if (isMobile) return Column(children: [img, const SizedBox(height: 32), info]);
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: p.imageOnLeft
          ? [Expanded(flex: 5, child: img),  const SizedBox(width: 64), Expanded(flex: 5, child: info)]
          : [Expanded(flex: 5, child: info), const SizedBox(width: 64), Expanded(flex: 5, child: img)],
    );
  }
}

class _ImageBox extends StatelessWidget {
  final Project p;
  const _ImageBox({required this.p});

  String get _img => p.title.contains('Calculator')
      ? 'assets/images/calculator-app.png'
      : 'assets/images/calendar-app.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Color(p.color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(_img,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.phone_android_rounded, size: 80,
                color: Colors.white.withOpacity(0.5))),
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final Project p;
  const _InfoBox({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(p.title, style: GoogleFonts.inter(
          color: Color(p.color), fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 16),
      Text(p.desc, style: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF), fontSize: 15, height: 1.8)),
      const SizedBox(height: 20),
      Wrap(spacing: 10, runSpacing: 10,
        children: p.tech.map((t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12)),
          child: Text(t, style: GoogleFonts.inter(
              color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
        )).toList()),
      const SizedBox(height: 28),
      OutlinedButton.icon(
        onPressed: () => openUrl(p.github),
        icon: const Icon(Icons.open_in_new_rounded, size: 16, color: Colors.white),
        label: Text('View Project', style: GoogleFonts.inter(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          side: const BorderSide(color: Colors.white38),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    ]);
  }
}
