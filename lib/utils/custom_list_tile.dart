import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final IconData trailingIcon;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(2, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: ListTile(
            leading: Icon(Icons.format_quote_rounded, color: Colors.grey[500]),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(subtitle),
            trailing: Icon(
              Icons.arrow_outward_rounded,
              color: Colors.grey[500],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
