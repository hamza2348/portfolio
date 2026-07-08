import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../utils/launcher.dart';

class SectionContact extends StatelessWidget {
  const SectionContact({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final px = isMobile ? 24.0 : 80.0;
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: TextSpan(children: [
          TextSpan(text: 'Get In ', style: GoogleFonts.inter(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
          TextSpan(text: 'Touch', style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6), fontSize: 36, fontWeight: FontWeight.w800)),
        ])),
        const SizedBox(height: 8),
        Text("Let's work together to bring your ideas to life",
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 15),
            textAlign: TextAlign.center),
        const SizedBox(height: 60),
        isMobile
          ? Column(children: [
              _Card(icon: Icons.email_outlined,      title: 'Email',    value: Info.email,    onTap: () => openUrl(Links.emailUrl)),
              const SizedBox(height: 16),
              _Card(icon: Icons.phone_outlined,      title: 'Phone',    value: Info.phone,    onTap: () => openUrl(Links.phoneUrl)),
              const SizedBox(height: 16),
              _Card(icon: Icons.location_on_outlined, title: 'Location', value: Info.location),
            ])
          : Row(children: [
              Expanded(child: _Card(icon: Icons.email_outlined,       title: 'Email',    value: Info.email,    onTap: () => openUrl(Links.emailUrl))),
              const SizedBox(width: 20),
              Expanded(child: _Card(icon: Icons.phone_outlined,       title: 'Phone',    value: Info.phone,    onTap: () => openUrl(Links.phoneUrl))),
              const SizedBox(width: 20),
              Expanded(child: _Card(icon: Icons.location_on_outlined, title: 'Location', value: Info.location)),
            ]),
        const SizedBox(height: 48),
        Text('Connect with me on social media',
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 15)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _Soc(Icons.code_rounded,         Links.github,    'GitHub'),
          const SizedBox(width: 14),
          _Soc(Icons.work_outline_rounded, Links.linkedin,  'LinkedIn'),
          const SizedBox(width: 14),
          _Soc(Icons.facebook_rounded,     Links.facebook,  'Facebook'),
          const SizedBox(width: 14),
          _Soc(Icons.camera_alt_outlined,  Links.instagram, 'Instagram'),
        ]),
      ]),
    );
  }
}

class _Card extends StatefulWidget {
  final IconData icon; final String title, value; final VoidCallback? onTap;
  const _Card({required this.icon, required this.title, required this.value, this.onTap});
  @override State<_Card> createState() => _CardState();
}
class _CardState extends State<_Card> {
  bool _h = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _h = true),
    onExit:  (_) => setState(() => _h = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: _h ? const Color(0xFF1A2540) : const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _h
              ? const Color(0xFF3B82F6).withOpacity(0.5)
              : Colors.white.withOpacity(0.07))),
        child: Column(children: [
          Container(width: 58, height: 58,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1E3A5F)),
              child: Icon(widget.icon, color: const Color(0xFF3B82F6), size: 26)),
          const SizedBox(height: 16),
          Text(widget.title, style: GoogleFonts.inter(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(widget.value, style: GoogleFonts.inter(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center),
        ]),
      ),
    ),
  );
}

class _Soc extends StatefulWidget {
  final IconData icon; final String url, tip;
  const _Soc(this.icon, this.url, this.tip);
  @override State<_Soc> createState() => _SocState();
}
class _SocState extends State<_Soc> {
  bool _h = false;
  @override
  Widget build(BuildContext context) => Tooltip(
    message: widget.tip,
    child: MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit:  (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 52, height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _h ? const Color(0xFF3B82F6) : const Color(0xFF1F2937),
            border: Border.all(color: _h ? const Color(0xFF3B82F6) : Colors.white12)),
          child: Icon(widget.icon, color: Colors.white, size: 22)),
      ),
    ),
  );
}
