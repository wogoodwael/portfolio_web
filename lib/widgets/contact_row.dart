import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final Uri? link;

  const ContactRow(this.icon, this.value, {this.link});

  void _launchLink(BuildContext context) async {
    if (link == null) return;
    if (await canLaunchUrl(link!)) {
      await launchUrl(link!, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $value')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget textWidget = Text(
      value,
      style: AppTheme.bodyMedium.copyWith(
        color: link != null ? AppTheme.primary : AppTheme.textPrimary,
        decoration: link != null ? TextDecoration.underline : null,
        decorationColor: AppTheme.primary
      ),
      overflow: TextOverflow.ellipsis,
    );

    return InkWell(
      onTap: link != null ? () => _launchLink(context) : null,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.primary),
          const SizedBox(width: 12),
          Expanded(child: textWidget),
        ],
      ),
    );
  }
}

