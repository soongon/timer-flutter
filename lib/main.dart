import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  int seconds = 0;
  bool isTicking = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _onTick(Timer time) {
    if (mounted && isTicking) {
      setState(() {
        ++seconds;
      });
    }
  }

  void _startTimer() {
    setState(() {
      isTicking = true;
    });
  }

  void _stopTimer() {
    setState(() {
      isTicking = false;
    });
  }

  String _secondsText() =>seconds == 1 ? 'second' : 'seconds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: _startTimer,
                child: Text('Start')
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                onPressed: _stopTimer,
                child: Text('Stop')
              ),

            ],
          )
        ],
      )
    );
  }
}
