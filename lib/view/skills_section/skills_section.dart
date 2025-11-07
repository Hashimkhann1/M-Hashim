import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  late Animation<double> _headingAnimation;

  final List<String> skills = const [
    'Flutter',
    'Dart',
    'Firebase',
    'REST APIs',
    'Local Storage',
    'MVC, MVVM',
    'UI/UX Design',
    'Notifications and background services',
    'Testing',
    'Provider',
    'Riverpod',
    'Bloc',
    'GetX',
    'Git',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Animation for heading
    _headingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    // Create staggered animations for each skill
    final itemCount = skills.length;
    _animations = List.generate(
      itemCount,
          (index) {
        final double start = (0.2 + (index * 0.03)).clamp(0.0, 0.7);
        final double end = (start + 0.3).clamp(0.0, 1.0);

        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              start,
              end,
              curve: Curves.easeOutCubic,
            ),
          ),
        );
      },
    );

    // Start animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  // Animated heading
                  AnimatedBuilder(
                    animation: _headingAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - _headingAnimation.value)),
                        child: Opacity(
                          opacity: _headingAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'Skills & Technologies',
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(skills.length, (index) {
                      return AnimatedBuilder(
                        animation: _animations[index],
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              20 * (1 - _animations[index].value),
                            ),
                            child: Opacity(
                              opacity: _animations[index].value,
                              child: child,
                            ),
                          );
                        },
                        child: _SkillChip(
                          key: ValueKey('skill_$index'),
                          skill: skills[index],
                          isMobile: isMobile,
                        ),
                      );
                    }),
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

class _SkillChip extends StatefulWidget {
  final String skill;
  final bool isMobile;

  const _SkillChip({
    Key? key,
    required this.skill,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (mounted) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (mounted) {
          setState(() => _isHovered = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 24 : 32,
          vertical: widget.isMobile ? 16 : 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF334155),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF60A5FA)
                : const Color(0xFF475569),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: const Color(0xFF60A5FA).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF60A5FA).withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: -5,
            ),
          ]
              : [],
        ),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            fontSize: widget.isMobile ? 14 : 16,
            color: _isHovered
                ? const Color(0xFFFFFFFF)
                : const Color(0xFFE2E8F0),
            fontWeight: FontWeight.w500,
          ),
          child: Text(widget.skill),
        ),
      ),
    );
  }
}