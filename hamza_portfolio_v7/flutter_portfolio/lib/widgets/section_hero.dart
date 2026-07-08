import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../utils/launcher.dart';

class SectionHero extends StatefulWidget {
  final VoidCallback onContact;
  const SectionHero({super.key, required this.onContact});
  @override State<SectionHero> createState() => _SectionHeroState();
}

class _SectionHeroState extends State<SectionHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final isMob  = size.width < 768;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height - 64),
      color: Colors.black,
      child: Stack(children: [
        // Animated background blobs
        AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => CustomPaint(
            painter: _BgPainter(_ctrl.value),
            size: Size(size.width, size.height),
          ),
        ),

        // ALL content centered
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMob ? 24 : 80, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile photo (only on desktop / if not too small)
                if (!isMob) ...[
                  _Avatar(),
                  const SizedBox(height: 32),
                ],

                // "Hi I am"
                Text('Hi I am',
                    style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 8),

                // Name
                Text(Info.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: isMob ? 44 : 72,
                        fontWeight: FontWeight.w800,
                        height: 1.1)),
                const SizedBox(height: 4),

                // Role in blue
                Text(Info.role,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: isMob ? 30 : 56,
                        fontWeight: FontWeight.w800,
                        height: 1.1)),
                const SizedBox(height: 32),

                // Social icons row — centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocIcon(icon: Icons.code_rounded,         url: Links.github,    tip: 'GitHub'),
                    const SizedBox(width: 14),
                    _SocIcon(icon: Icons.work_outline_rounded, url: Links.linkedin,  tip: 'LinkedIn'),
                    const SizedBox(width: 14),
                    _SocIcon(icon: Icons.facebook_rounded,     url: Links.facebook,  tip: 'Facebook'),
                    const SizedBox(width: 14),
                    _SocIcon(icon: Icons.camera_alt_outlined,  url: Links.instagram, tip: 'Instagram'),
                  ],
                ),
                const SizedBox(height: 32),

                // Buttons row — centered
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20, runSpacing: 14,
                  children: [
                    // Contact Me — solid blue pill
                    ElevatedButton(
                      onPressed: widget.onContact,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                      child: const Text('Contact Me'),
                    ),

                    // Download CV — outlined pill → opens CV image directly
                    OutlinedButton.icon(
                      onPressed: () => openUrl(Links.cvDirect),
                      icon: const Icon(Icons.download_rounded,
                          size: 20, color: Colors.white),
                      label: Text('Download CV',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 34, vertical: 18),
                        side: const BorderSide(
                            color: Colors.white60, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Stats — centered
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 48, runSpacing: 24,
                  children: [
                    _Stat(Info.statExp,            'Experience'),
                    _Stat(Info.statProjects,       'Projects Done'),
                    _Stat(Info.statContributions,  'Contributions'),
                  ],
                ),

                // Mobile: show avatar below stats
                if (isMob) ...[
                  const SizedBox(height: 48),
                  _Avatar(),
                ],
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ── Profile avatar ───────────────────────────────────────────────────────────
class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMob = MediaQuery.of(context).size.width < 768;
    final sz    = isMob ? 180.0 : 220.0;
    return Stack(alignment: Alignment.center, children: [
      // Glow
      Container(
        width: sz + 28, height: sz + 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.45),
              blurRadius: 50, spreadRadius: 8)],
        ),
      ),
      // Blue ring + photo
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
              color: const Color(0xFF1F2937),
              child: const Icon(Icons.person_rounded,
                  size: 100, color: Colors.white24)),
          ),
        ),
      ),
    ]);
  }
}

// ── Animated background blobs ────────────────────────────────────────────────
class _BgPainter extends CustomPainter {
  final double t;
  _BgPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    void blob(double cx, double cy, double r, double opacity) {
      canvas.drawCircle(
        Offset(cx, cy), r,
        Paint()
          ..color = const Color(0xFF3B82F6).withOpacity(opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90),
      );
    }

    blob(
      size.width * 0.5 + sin(t * 2 * pi) * size.width * 0.12,
      size.height * 0.3 + cos(t * 2 * pi) * size.height * 0.08,
      280, 0.08,
    );
    blob(
      size.width * 0.2 + cos(t * 2 * pi + 1.5) * size.width * 0.06,
      size.height * 0.6 + sin(t * 2 * pi + 1.5) * size.height * 0.07,
      200, 0.06,
    );
    blob(
      size.width * 0.8 + sin(t * 2 * pi + 3) * size.width * 0.07,
      size.height * 0.4 + cos(t * 2 * pi + 3) * size.height * 0.05,
      160, 0.05,
    );

    // Dot grid
    final dp = Paint()..color = Colors.white.withOpacity(0.02);
    for (var x = 0.0; x < size.width; x += 50)
      for (var y = 0.0; y < size.height; y += 50)
        canvas.drawCircle(Offset(x, y), 1.2, dp);
  }

  @override bool shouldRepaint(_BgPainter o) => o.t != t;
}

// ── Social icon ───────────────────────────────────────────────────────────────
class _SocIcon extends StatefulWidget {
  final IconData icon; final String url, tip;
  const _SocIcon({required this.icon, required this.url, required this.tip});
  @override State<_SocIcon> createState() => _SocIconState();
}
class _SocIconState extends State<_SocIcon> {
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
          width: 50, height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _h ? const Color(0xFF3B82F6) : const Color(0xFF1F2937),
            border: Border.all(
                color: _h ? const Color(0xFF3B82F6) : Colors.white24)),
          child: Icon(widget.icon, color: Colors.white, size: 22),
        ),
      ),
    ),
  );
}

// ── Stat ──────────────────────────────────────────────────────────────────────
class _Stat extends StatelessWidget {
  final String num, label;
  const _Stat(this.num, this.label);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(num, style: GoogleFonts.inter(
          color: const Color(0xFF3B82F6),
          fontSize: 40, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(label, style: GoogleFonts.inter(
          color: Colors.white54, fontSize: 15)),
    ],
  );
}
