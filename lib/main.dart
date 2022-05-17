import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();

    _currentSeconds = 5 * 60;
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_currentSeconds < 1) {
          timer.cancel();
        } else {
          setState(() {
            _currentSeconds = _currentSeconds - 1;
          });
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _currentSeconds = 300;
    });
  }

  void add() {
    setState(() {
      _currentSeconds = _currentSeconds + 60;
    });
  }

  void minus() {
    setState(() {
      _currentSeconds = _currentSeconds - 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (int leftSeconds) {
                final minutes =
                    (leftSeconds / 60).floor().toString().padLeft(2, '0');
                final seconds =
                    (leftSeconds % 60).floor().toString().padLeft(2, '0');
                return '$minutes:$seconds';
              }(_currentSeconds),
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 150),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: startTimer,
            tooltip: 'start',
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: stopTimer,
            tooltip: 'stop',
            child: const Icon(Icons.stop),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: resetTimer,
            tooltip: 'reset',
            child: const Icon(Icons.reset_tv),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: add,
            tooltip: 'add',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: minus,
            tooltip: 'minus',
            child: const Icon(Icons.line_axis),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
