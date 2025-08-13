import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goToBrach(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("Fitur ini belum tersedia"),
          //     action: SnackBarAction(label: 'Tutup', onPressed: () {}),
          //   ),
          // );
          
        },
        backgroundColor: Color(0xFF113F67),
        child: const Icon(Icons.dark_mode, color: Colors.white),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          _goToBrach(selectedIndex);
        },
        iconSize: 30,
        activeColor: Colors.black,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(title: 'Home', icon: Icons.home),
          BarItem(title: 'Bookmark', icon: Icons.bookmark),
        ],
      ),
    );
  }
}
