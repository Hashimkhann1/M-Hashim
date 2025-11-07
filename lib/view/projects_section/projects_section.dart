import 'package:flutter/material.dart';
import 'package:portfolio/view/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  Text(
                    'Featured Projects',
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        return Column(
                          children: [
                            const ProjectCard(projectNumber: 1),
                            const SizedBox(height: 24),
                            const ProjectCard(projectNumber: 2),
                            const SizedBox(height: 24),
                            const ProjectCard(projectNumber: 3),
                            const SizedBox(height: 24),
                            const ProjectCard(projectNumber: 4),
                          ],
                        );
                      } else {
                        return Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: [
                            SizedBox(
                              width: (constraints.maxWidth - 24) / 2,
                              child: const ProjectCard(projectNumber: 1),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 24) / 2,
                              child: const ProjectCard(projectNumber: 2),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 24) / 2,
                              child: const ProjectCard(projectNumber: 3),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 24) / 2,
                              child: const ProjectCard(projectNumber: 4),
                            ),
                          ],
                        );
                      }
                    },
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