import 'dart:async';

import 'package:flappy_bird_game/barriers.dart';

import 'bird.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double birdYAxis = 0;
  double height = 0;
  double time = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  late int score = 0;
  late int bestScore = 0;
  static double barrierXOne = 2;
  double barrierXTwo = barrierXOne + 1.5;

  bool birdIsDead() {
    if (birdYAxis > 1 || birdYAxis < -1) {
      return true;
    }
    return false;
  }

  void jump() {
    setState(() {
      time = 0;
      score += 1;
      initialHeight = birdYAxis;
    });
    if (score >= bestScore) {
      bestScore = score;
    }
  }

  void startGame() {
    gameHasStarted = true;
    score = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
        if (barrierXOne < -1.1) {
          barrierXOne += 2.2;
        } else {
          barrierXOne -= 0.05;
        }
        if (birdIsDead()) {
          _showDialog();
          timer.cancel();
        }
        if (barrierXTwo < -1.1) {
          barrierXTwo += 2.2;
        } else {
          barrierXTwo -= 0.05;
        }
      });
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYAxis = 0;
      time = 0;
      initialHeight = birdYAxis;
      gameHasStarted = false;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Center(
            child: Image.asset(
              'assets/game-over.png',
              width: 190.0,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: const Text(
                    'Start Again',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.lightBlueAccent,
                    child: const Bird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.65),
                    child: gameHasStarted
                        ? const Text('')
                        : Image.asset('assets/play.png'),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.3),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.2),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.2),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(size: 250.0),
                  ),
                ],
              )),
          Container(
            height: 16.0,
            color: Colors.amber,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    Image.asset(
                      'assets/score.png',
                      width: 80.0,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    const Text(
                      'SCORE',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      score.toString(),
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    Image.asset(
                      'assets/top.png',
                      width: 80.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      bestScore.toString(),
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
