import 'package:flutter/material.dart';

class TemplateSection extends StatelessWidget {
  const TemplateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Template',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TemplateItem(icon: Icons.flutter_dash, title: 'Flutter/Dart'),
        TemplateItem(icon: Icons.web, title: 'Web'),
        TemplateItem(icon: Icons.computer, title: 'Backend/Python'),
      ],
    );
  }
}

class TemplateItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const TemplateItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onTap;
          debugPrint('Tapped!');
        },
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
