
import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key key, this.duration}) : super(key: key);
  final Duration duration;
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  static final Duration _tick = Duration(milliseconds: 10);
  static final Duration _defaultDuration = Duration(minutes: 25);
  static final TextStyle _timeTextStyle =
      TextStyle(color: Colors.white, fontSize: 30);
  static final SnackBar _breakMessage = SnackBar(
      content: Text('It\'s time to take a break!',
          style: TextStyle(fontFamily: 'IBM Plex Sans')));
  Timer _timer;
  Duration _duration;
  Duration _countdown;
  DateTime _endTime;
  String _buttonText;

  @override
  void initState() {
    setState(() {
      _duration = widget.duration ?? _defaultDuration;
      resetTimer();
    });
    super.initState();
  }

  void startTimer(BuildContext context) {
    _endTime = DateTime.now().add(_duration);
    _timer = Timer.periodic(
        _tick,
        (Timer timer) => setState(() {
              _countdown = _endTime.difference(DateTime.now());
              if (DateTime.now().isAfter(_endTime)) {
                stopTimer();
                // alarmRing();
                Scaffold.of(context).showSnackBar(_breakMessage);
              }
            }));
    _buttonText = 'Stop';
  }

  void stopTimer() => setState(() {
        _buttonText = 'Reset';
        _timer.cancel();
      });

  void resetTimer() => setState(() {
        _countdown = _duration;
        _buttonText = 'Start';
      });

  void buttonPress(BuildContext context) {
    if (_timer?.isActive ?? false) {
      stopTimer();
    } else {
      if (_countdown == _duration) {
        startTimer(context);
      } else {
        resetTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_countdown.inMinutes}',
                  style: _timeTextStyle,
                ),
                Text(
                  ':',
                  style: _timeTextStyle,
                ),
                Text(
                  (_countdown.inSeconds - (_countdown.inMinutes * 60))
                      .toString()
                      .padLeft(2, '0'),
                  style: _timeTextStyle,
                )
              ],
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text(_buttonText),
              shape: StadiumBorder(),
              onPressed: () => buttonPress(context),
            ),
          ],
        ),
      ],
    );
  }
}
