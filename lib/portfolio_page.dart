import 'package:flutter/material.dart';
import 'package:flutter_portfolio/about_section.dart';
import 'package:flutter_portfolio/certs_languages_section.dart';
import 'package:flutter_portfolio/footer_section.dart';
import 'package:flutter_portfolio/hero_section.dart';
import 'package:flutter_portfolio/nav_bar.dart';
import 'package:flutter_portfolio/projects_section.dart';
import 'package:flutter_portfolio/skills_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioNavBar(scrollController: _scrollController),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: const Column(
          children: [
            HeroSection(),
            AboutSection(),
            SkillsSection(),
            ProjectsSection(),
            CertsLanguagesSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
