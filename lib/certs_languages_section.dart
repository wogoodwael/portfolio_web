import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/widgets/education_bank.dart';
import 'package:flutter_portfolio/widgets/languages_bloc.dart';

class CertsLanguagesSection extends StatelessWidget {
  const CertsLanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      color: AppTheme.surfaceAlt,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _CertificatesBlock(),
                const SizedBox(height: 48),
                LanguagesBlock(),
                const SizedBox(height: 48),
                EducationBlock(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(flex: 3, child: _CertificatesBlock()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: LanguagesBlock()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: EducationBlock()),
              ],
            ),
    );
  }
}



