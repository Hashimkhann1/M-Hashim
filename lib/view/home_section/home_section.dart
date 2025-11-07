import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0F172A),
            const Color(0xFF1E293B),
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 60 : 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture
                  Container(
                    width: isMobile ? 120 : 160,
                    height: isMobile ? 120 : 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF9333EA)],
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF334155),
                      ),
                      child: Center(
                        child: Text(
                          'MH',
                          style: TextStyle(
                            fontSize: isMobile ? 40 : 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 32),

                  // Name
                  Text(
                    'M Hashim',
                    style: TextStyle(
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),

                  // Title
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 28,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 20 : 24),

                  // Tagline
                  Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'I craft beautiful and performant mobile and web applications using Flutter. Passionate about creating seamless user experiences and bringing innovative ideas to life through elegant code and stunning designs.',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 18,
                        color: const Color(0xFF94A3B8),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}