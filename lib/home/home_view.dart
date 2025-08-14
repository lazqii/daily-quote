import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:daily_quote/login/login_page.dart';
import 'package:daily_quote/models/quote.dart';
import 'package:daily_quote/services/quote_service.dart';
import 'package:daily_quote/utils/quote_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _email;

  @override
  void initInstate() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final preference = await SharedPreferences.getInstance();
    setState(() => _email = preference.getString('email'));
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('email'); // hapus yang perlu saja

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFEEBF6),
        body: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
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
                                'Selamat datang${_email != null ? ', $_email' : ''}!',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF687FE5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Bagaimana kabarmu?",
                                style: TextStyle(
                                  fontSize: 20,
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
                            // padding: EdgeInsets.all(4),
                            child: IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  customHeader: Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.amber,
                                    size: 55,
                                  ),
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  title: 'TUNGGUU!!!',
                                  desc: 'Kamu yakin mau logout?🥺',
                                  descTextStyle: TextStyle(fontSize: 18),
                                  btnCancelOnPress: () {},
                                  btnCancelText: 'Batal',
                                  btnOkOnPress: _logout,
                                  btnOkText: 'Ya',
                                ).show();
                              },
                              icon: Icon(Icons.logout_outlined),
                              color: Colors.white,
                              iconSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Quotes of The Day",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF687FE5),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              //List quote
              Expanded(
                child: FutureBuilder<List<Quote>>(
                  future: fetchMultipleQuotes(8),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return QuoteListWidget(quotes: snapshot.data!);
                    } else {
                      return const Center(child: Text('No quotes found'));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'Quotes powered by ZenQuotes.io',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
