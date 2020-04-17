
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void CounterChangeCallback(num value);

class Counter extends StatefulWidget {

  Counter({
    @required this.initialValue,
    @required this.selectedValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step,
    this.buttonSize = 25,
  }) ;
        

  final CounterChangeCallback onChanged;

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  final num initialValue;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CounterState(
      initialValue:initialValue, 
      selectedValue: selectedValue,
      minValue: minValue,
      maxValue: maxValue,
      onChanged: onChanged,
      decimalPlaces: decimalPlaces,
      color: color,
      textStyle: textStyle,
      step: step,
      buttonSize: buttonSize);
  }
}

class CounterState extends State<Counter>{

  final CounterChangeCallback onChanged;

  CounterState({
    @required this.initialValue,
    @required this.selectedValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step,
    this.buttonSize = 25,
  });

  final num initialValue;

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      selectedValue += step;
      onChanged((selectedValue));
      setState(() {
      });
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      selectedValue -= step;
      onChanged((selectedValue));
            setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color ?? themeData.accentColor;
    textStyle = textStyle ?? new TextStyle(
      fontSize: 20.0,
    );

    return new Container(
      padding: new EdgeInsets.all(4.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              heroTag: "decrement hero tag",
              onPressed: _decrementCounter,
              elevation: 2,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
              backgroundColor: color,
            ),
          ),
          new Container(
            padding: EdgeInsets.all(4.0),
            child: new Text(
                '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
                style: textStyle
            ),
          ),
          new SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              heroTag: "increment hero tag",
              onPressed: _incrementCounter,
              elevation: 2,
              tooltip: 'Increment',
              child: Icon(Icons.add),
              backgroundColor: color,
            ),
          ),
        ],
      ),
    );
  }
}