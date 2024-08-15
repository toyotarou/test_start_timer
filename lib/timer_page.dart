import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_timer_start/button_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  //static const defaultSeconds = 10;
  int maxSeconds = 10;
  int seconds = 10;
  Timer? timer;

  ///
  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    // seconds: 1
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          setState(() => seconds--);
        } else {
          stopTimer(reset: false);
          seconds = maxSeconds;
        }
      },
    );
  }

  ///
  void resetTimer() => setState(() => seconds = maxSeconds);

  ///
  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  ///
  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    final timeController = TextEditingController();

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: isRunning ? '停止' : '再開',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(reset: false);
                    } else {
                      startTimer(reset: false);
                    }
                  }),
              const SizedBox(width: 12),
              ButtonWidget(
                text: '初めから',
                onClicked: () => resetTimer(),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: '秒数を入力してください',
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
                controller: timeController,
              ),
              ButtonWidget(
                text: 'スタート',
                color: Colors.black,
                backgroundColor: Colors.white,
                onClicked: () {
                  maxSeconds = int.parse(timeController.text);
                  startTimer();
                },
              ),
            ],
          );
  }

  ///
  Widget buildTimer() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 12,
            backgroundColor: Colors.greenAccent,
          ),
          Center(
            child: buildTime(),
          )
        ],
      ),
    );
  }

  ///
  Widget buildTime() {
    return Text(
      '$seconds',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 80,
      ),
    );
  }
}
