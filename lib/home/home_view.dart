import 'package:daily_quote/utils/custom_list_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFEEBF6),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Halo, User!",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF687FE5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Bagaimana kabarmu?",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF687FE5),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 139, 157, 240),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.notifications, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Quotes of The Day",
                      style: TextStyle(fontSize: 25, color: Color(0xFF687FE5)),
                    ),
                    SizedBox(height: 16),

                    //ListTIle Quote
                    CustomListTile(
                      leadingIcon: Icons.format_quote_rounded,
                      title: 'Kalau bisa besok, kenapa harus sekarang?',
                      subtitle: '\nAnonim 2124',
                      trailingIcon: Icons.arrow_outward_rounded,
                    ),
                    CustomListTile(
                      leadingIcon: Icons.format_quote_rounded,
                      title: 'Kalau bisa orang lain, kenapa harus saya?',
                      subtitle: '\nAnonim 2124',
                      trailingIcon: Icons.arrow_outward_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
