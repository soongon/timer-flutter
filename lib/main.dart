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

  int milliseconds = 0;
  bool isTicking = true;

  final laps = <int>[];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _onTick(Timer time) {
    if (mounted && isTicking) {
      setState(() {
        milliseconds += 100;
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

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lap ${laps.length + 1}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  Text(
                    _secondsText(milliseconds),
                    style: Theme.of(context).textTheme.headlineMedium,
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
                          backgroundColor: WidgetStateProperty.all(Colors.yellow),
                          foregroundColor: WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: _lap,
                        child: Text('Lap')
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
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  children: [
                    for (int milliseconds in laps)
                      ListTile(
                        title: Text(_secondsText(milliseconds)),
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
