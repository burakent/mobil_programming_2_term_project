import 'dart:async';

import 'package:final_project/games/barrier.dart';
import 'package:final_project/games/bird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlappyHome extends StatefulWidget {
  const FlappyHome({Key? key}) : super(key: key);

  @override
  State<FlappyHome> createState() => _FlappyHomeState();
}

class _FlappyHomeState extends State<FlappyHome> {
  static double birdY = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // strong of gravity
  double velocity = 3.5; // strong of jump
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  //game settings
  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPosition - height;
      });

      // check if bird dead
      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      moveMap();

      time += 0.01;

    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void resetMap() {
    barrierX = [2, 2 + 1.5];
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPosition = birdY;
      resetMap();
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "OYUN BİTTİ",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      "TEKRAR OYNA",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blue,
              child: Center(
                  child: Stack(
                children: [
                  MyBird(
                    birdY: birdY,
                    birdWidth: birdWidth,
                    birdHeight: birdHeight,
                  ),
                  Container(
                    alignment: Alignment(0, -0.5),
                    child: Text(gameHasStarted ? "" : "OYNAMAK İÇİN TIKLA",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  //top barrier
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][0],
                    isThisBottomBarrier: false,
                  ),
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][1],
                    isThisBottomBarrier: true,
                  ),
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][0],
                    isThisBottomBarrier: false,
                  ),
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][0],
                    isThisBottomBarrier: true,
                  )
                ],
              )),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          ),
        ]),
      ),
    );
  }
}
