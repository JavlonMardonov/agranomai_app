import 'package:agranom_ai/data/services/data.dart';
import 'package:agranom_ai/presentation/screens/history_screen.dart';
import 'package:agranom_ai/presentation/widgets/custom_appbar.dart';
import 'package:agranom_ai/presentation/widgets/landing_widget.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LandingWidget(),
    // const CameraScreen(),
    HistoryWidget(history: history),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EDE7),
      appBar: _currentIndex == 1 ? HistoryAppBar() : const CustomAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xff81C784),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.camera_alt_outlined,
            //     color: Colors.white,
            //     size: 35,
            //   ),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Colors.white,
                size: 35,
              ),
              label: '',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CircleAvatar(
          maxRadius: 30,
          backgroundColor: Color(0xffF5EDE7),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, "/camera"),
            icon: Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
