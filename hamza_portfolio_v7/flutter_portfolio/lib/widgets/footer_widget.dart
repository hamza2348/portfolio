import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../utils/launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      color: const Color(0xFF111827),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 28),
      child: isMobile
        ? Column(children: [_logo(), const SizedBox(height: 12), _copy(), const SizedBox(height: 16), _socials()])
        : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_logo(), _copy(), _socials()]),
    );
  }

  Widget _logo() => RichText(text: TextSpan(children: [
    TextSpan(text: 'HAMZA', style: GoogleFonts.inter(
        color: const Color(0xFF3B82F6), fontSize: 16,
        fontWeight: FontWeight.w800, letterSpacing: 1)),
    TextSpan(text: 'SATTAR', style: GoogleFonts.inter(
        color: Colors.white, fontSize: 16,
        fontWeight: FontWeight.w800, letterSpacing: 1)),
  ]));

  Widget _copy() => Text('© 2026 ${Info.name}. All rights reserved.',
      style: GoogleFonts.inter(color: Colors.white38, fontSize: 13));

  Widget _socials() => Row(mainAxisSize: MainAxisSize.min, children: [
    _I(Icons.code_rounded,         Links.github,    'GitHub'),
    const SizedBox(width: 14),
    _I(Icons.work_outline_rounded, Links.linkedin,  'LinkedIn'),
    const SizedBox(width: 14),
    _I(Icons.facebook_rounded,     Links.facebook,  'Facebook'),
    const SizedBox(width: 14),
    _I(Icons.camera_alt_outlined,  Links.instagram, 'Instagram'),
  ]);
}

class _I extends StatefulWidget {
  final IconData icon; final String url, tip;
  const _I(this.icon, this.url, this.tip);
  @override State<_I> createState() => _IState();
}
class _IState extends State<_I> {
  bool _h = false;
  @override
  Widget build(BuildContext context) => Tooltip(
    message: widget.tip,
    child: MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit:  (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: Icon(widget.icon,
            color: _h ? const Color(0xFF3B82F6) : Colors.white38, size: 20)),
    ),
  );
}
