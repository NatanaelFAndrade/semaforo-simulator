import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Semaforo extends StatefulWidget {
  const Semaforo({super.key});

  @override
  State<Semaforo> createState() => _SemaforoState();
}

class _SemaforoState extends State<Semaforo> {
  Color _stop = const Color(0xffCD0836);
  Color _start = Colors.grey;
  Color _caution = Colors.grey;

  late Timer _timer;
  int _tempoAtual = 0;

  @override
  void initState() {
    changeStatusBar();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tempoAtual == 0) {
          _stop = Colors.grey;
          _caution = const Color(0xffFFCD02);
          _start = Colors.grey;
        } else if (_tempoAtual == 5) {
          _stop = Colors.grey;
          _caution = Colors.grey;
          _start = const Color(0xff07CF1A);
        } else if (_tempoAtual == 8) {
          _stop = const Color(0xffCD0836);
          _caution = Colors.grey;
          _start = Colors.grey;
          _tempoAtual = -1;
        }
        _tempoAtual++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  changeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: primaryColor,
    ));
  }

  static const primaryColor = Colors.indigoAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Respeite o semáforo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 250,
          height: 450,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xff34495E),
              borderRadius: BorderRadius.circular(22)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: _stop,
                radius: 50,
              ),
              const SizedBox(height: 15),
              CircleAvatar(
                backgroundColor: _caution,
                radius: 50,
              ),
              const SizedBox(height: 15),
              CircleAvatar(
                backgroundColor: _start,
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
