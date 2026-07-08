import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatelessWidget {
  final int active;
  final void Function(int) onTap;
  const NavBar({super.key, required this.active, required this.onTap});

  static const _items = ['Home','About','Skills','Services','Projects','Contact'];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        height: 64,
        color: Colors.black.withOpacity(0.95),
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48),
        child: Row(children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: RichText(text: TextSpan(children: [
              TextSpan(text: 'HAMZA', style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6), fontSize: 20,
                  fontWeight: FontWeight.w800, letterSpacing: 1.5)),
              TextSpan(text: 'SATTAR', style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 20,
                  fontWeight: FontWeight.w800, letterSpacing: 1.5)),
            ])),
          ),
          const Spacer(),
          if (!isMobile)
            Row(children: List.generate(_items.length, (i) => TextButton(
              onPressed: () => onTap(i),
              child: Text(_items[i], style: GoogleFonts.inter(
                  color: active == i ? const Color(0xFF3B82F6) : Colors.white,
                  fontWeight: active == i ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 15)),
            ))),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => onTap(5),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text('Contact Me', style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          if (isMobile) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFF111827),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                builder: (_) => Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 8),
                  Container(width: 40, height: 4,
                      decoration: BoxDecoration(color: Colors.white24,
                          borderRadius: BorderRadius.circular(2))),
                  ...List.generate(_items.length, (i) => ListTile(
                    title: Text(_items[i], style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 16)),
                    onTap: () { Navigator.pop(context); onTap(i); },
                  )),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
          ],
        ]),
      ),
    );
  }
}
