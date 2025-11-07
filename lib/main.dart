import 'package:flutter/material.dart';
import 'package:portfolio/view/contact_section/contact_section.dart';
import 'package:portfolio/view/home_section/home_section.dart';
import 'package:portfolio/view/projects_section/projects_section.dart';
import 'package:portfolio/view/skills_section/skills_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M Hashim - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
        fontFamily: 'Inter',
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());
  int _selectedIndex = 0;

  final List<String> _sectionTitles = [
    'Home',
    'Skills',
    'Projects',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final RenderBox? renderBox = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero).dy;
        if (position <= 100 && position >= -renderBox.size.height + 100) {
          if (_selectedIndex != i) {
            setState(() => _selectedIndex = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final RenderBox? renderBox = _sectionKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero).dy;
      final offset = _scrollController.offset + position - 80;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onFabTap() {
    if (_selectedIndex == _sectionKeys.length - 1) {
      // If on last section, go back to home
      _scrollToSection(0);
    } else {
      // Go to next section
      _scrollToSection(_selectedIndex + 1);
    }
  }

  String _getFabText() {
    if (_selectedIndex == _sectionKeys.length - 1) {
      return 'Home Section';
    } else {
      return '${_sectionTitles[_selectedIndex + 1]} Section';
    }
  }

  IconData _getFabIcon() {
    if (_selectedIndex == _sectionKeys.length - 1) {
      return Icons.arrow_upward_rounded;
    } else {
      return Icons.arrow_downward_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildSection(0, const HeroSection()),
            _buildSection(1, const SkillsSection()),
            _buildSection(2, const ProjectsSection()),
            _buildSection(3, const ContactSection()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onFabTap,
        backgroundColor: const Color(0xFF162040),
        elevation: 6,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Icon(
            _getFabIcon(),
            key: ValueKey<IconData>(_getFabIcon()),
            color: Colors.white,
          ),
        ),
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            _getFabText(),
            key: ValueKey<String>(_getFabText()),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(int index, Widget child) {
    return Container(
      key: _sectionKeys[index],
      child: child,
    );
  }
}