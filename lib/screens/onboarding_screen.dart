import 'package:flutter/material.dart';
import 'home_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

final _controller = PageController();
int _currentPage = 0;

final List<Map<String, String>> splashData = [
  {
    "title": "Kudos means\nwell done",
    "subtitle":
        "Gratitude is the most heartwarming\nfeeling. Praise someone in the\neasiest way possible",
    "image": "assets/images/splash_1.png"
  },
  {
    "title": "Get inspired",
    "subtitle":
        "Browse kudos list. See what your\ncommunity is up to and\nget inspired",
    "image": "assets/images/splash_2.png"
  },
  {
    "title": "Spread\nkindness",
    "subtitle": "Do your best in your day to day life\nand unlock achievements",
    "image": "assets/images/splash_3.png"
  }
];

AnimatedContainer _buildDots({int index}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      color: const Color(0xFF293241),
    ),
    margin: const EdgeInsets.only(right: 5),
    height: 10,
    curve: Curves.easeIn,
    width: _currentPage == index ? 20 : 10,
  );
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                itemCount: splashData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          splashData[index]['title'].toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF424242),
                          ),
                        ),
                      ),
                      Text(
                        splashData[index]['subtitle'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          splashData[index]['image'],
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  );
                },
                onPageChanged: (value) => setState(() => _currentPage = value),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        onPressed: () {
                          _currentPage + 1 == splashData.length
                              ? Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage()))
                              : _controller.nextPage(
                                  duration: const Duration(microseconds: 200),
                                  curve: Curves.easeIn,
                                );
                        },
                        child: Text(
                          _currentPage + 1 == splashData.length
                              ? 'Go to app'
                              : 'Continue',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: const Color(0xFF68B684),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
