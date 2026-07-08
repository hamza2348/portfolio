import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../utils/launcher.dart';

class SectionAbout extends StatelessWidget {
  const SectionAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final px = isMobile ? 24.0 : 80.0;
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: isMobile
          ? Column(children: [_photo(), const SizedBox(height: 40), _content()])
          : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(flex: 4, child: _photo()),
              const SizedBox(width: 64),
              Expanded(flex: 6, child: _content()),
            ]),
    );
  }

  Widget _photo() {
    const sz = 290.0;
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: sz + 20, height: sz + 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.35),
                blurRadius: 50, spreadRadius: 8)],
          ),
        ),
        Container(
          width: sz, height: sz,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              width: sz, height: sz, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF111827),
                child: const Icon(Icons.person_rounded,
                    size: 140, color: Colors.white12)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _content() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(text: TextSpan(children: [
        TextSpan(text: 'About ', style: GoogleFonts.inter(
            color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
        TextSpan(text: 'Me', style: GoogleFonts.inter(
            color: const Color(0xFF3B82F6), fontSize: 36, fontWeight: FontWeight.w800)),
      ])),
      const SizedBox(height: 24),
      Text(Info.about1, style: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF), fontSize: 15, height: 1.8)),
      const SizedBox(height: 16),
      Text(Info.about2, style: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF), fontSize: 15, height: 1.8)),
      const SizedBox(height: 32),
      Wrap(spacing: 48, runSpacing: 20, children: [
        _Pair('Age',          Info.age),
        _Pair('Experience',   Info.experience),
        _Pair('Location',     Info.location),
        _Pair('Availability', Info.availability),
      ]),
      const SizedBox(height: 32),
      ElevatedButton.icon(
        onPressed: () => openUrl(Links.emailUrl),
        icon: const Icon(Icons.download_rounded, size: 18),
        label: const Text('Download CV'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
    ]);
  }
}

class _Pair extends StatelessWidget {
  final String l, v;
  const _Pair(this.l, this.v);
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(l, style: GoogleFonts.inter(color: Colors.white38, fontSize: 13)),
      const SizedBox(height: 4),
      Text(v, style: GoogleFonts.inter(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
    ],
  );
}
