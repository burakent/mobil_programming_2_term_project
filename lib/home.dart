import 'package:final_project/header.dart';
import 'package:final_project/quizzes/quiz_home.dart';
import 'package:flutter/material.dart';
import 'currency/currency.dart';
import 'games/flappy_home.dart';
import 'news/news.dart';
import 'musics/music.dart';
import 'weathers/weather.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomCard(
                      color: Colors.deepOrange,
                      onTap: () {
                        navigateTo(context, const News());
                      },
                      icon: Icons.newspaper_sharp,
                      title: 'NEWS',
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: Colors.limeAccent,
                      onTap: () {
                        navigateTo(context, const FlappyHome());
                      },
                      icon: Icons.gamepad_sharp,
                      title: 'GAMES',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomCard(
                      color: Colors.green,
                      onTap: () {
                        navigateTo(context, const MusicPlayer());
                      },
                      icon: Icons.music_note_sharp,
                      title: 'MUSIC',
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: Colors.black38,
                      onTap: () {
                        navigateTo(context,  Weather());
                      },
                      icon: Icons.cloudy_snowing,
                      title: 'FORECAST',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomCard(
                      color: const Color(0xffBD2888),
                      onTap: () {
                        navigateTo(context, const QuestionWidget());
                      },
                      icon: Icons.quiz_sharp,
                      title: 'QUIZ',
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: const Color(0xff38B3AE),
                      onTap: () {
                        navigateTo(context, const Currency());
                      },
                      icon: Icons.currency_bitcoin_sharp,
                      title: 'CURRENCY',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: const Color(0xffC90003),
          onTap: onTap,
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 35,
                      color: Colors.white,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
