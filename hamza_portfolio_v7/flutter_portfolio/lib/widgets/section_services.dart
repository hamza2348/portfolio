import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';

class SectionServices extends StatelessWidget {
  const SectionServices({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 700;
    final px = isMobile ? 24.0 : 80.0;
    final cols = w > 1100 ? 3 : w > 700 ? 2 : 1;

    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: TextSpan(children: [
          TextSpan(text: 'My ', style: GoogleFonts.inter(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
          TextSpan(text: 'Services', style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6), fontSize: 36, fontWeight: FontWeight.w800)),
        ])),
        const SizedBox(height: 8),
        Text('Solutions I provide for your digital needs',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 15),
            textAlign: TextAlign.center),
        const SizedBox(height: 60),
        LayoutBuilder(builder: (_, box) {
          final cw = (box.maxWidth - (cols - 1) * 20) / cols;
          final rows = <Widget>[];
          for (var i = 0; i < kServices.length; i += cols) {
            final row = <Widget>[];
            for (var j = 0; j < cols && i + j < kServices.length; j++) {
              row.add(SizedBox(width: cw,
                  child: _Card(s: kServices[i + j], idx: i + j)));
            }
            rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: row.expand((w) => [w, const SizedBox(width: 20)])
                    .toList()..removeLast()));
            if (i + cols < kServices.length) rows.add(const SizedBox(height: 20));
          }
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
        }),
      ]),
    );
  }
}

class _Card extends StatefulWidget {
  final Service s; final int idx;
  const _Card({required this.s, required this.idx});
  @override State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool _h = false;

  IconData _icon() {
    switch (widget.s.title) {
      case 'Flutter App Development': return Icons.phone_android_rounded;
      case 'Dart Programming':        return Icons.code_rounded;
      case 'UI/UX Design':            return Icons.palette_rounded;
      case 'Backend Integration':     return Icons.storage_rounded;
      case 'App Maintenance':         return Icons.layers_rounded;
      case 'API Development':         return Icons.public_rounded;
      default:                        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit:  (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _h ? const Color(0xFF1A2540) : const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: _h ? const Color(0xFF3B82F6).withOpacity(0.5)
                        : Colors.white.withOpacity(0.07)),
          boxShadow: _h ? [BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.1), blurRadius: 30)] : [],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(color: const Color(0xFF1E3A5F),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(_icon(), color: const Color(0xFF3B82F6), size: 26)),
          const SizedBox(height: 20),
          Text(widget.s.title, style: GoogleFonts.inter(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(widget.s.desc, style: GoogleFonts.inter(
              color: Colors.white54, fontSize: 14, height: 1.7)),
        ]),
      ),
    );
  }
}
