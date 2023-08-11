import 'package:flutter/material.dart';
import 'ReversePolish.dart';

void main() {
  runApp(MaterialApp(
    title: 'my calculator',
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  var str = '';
  var getAns = false;

  void handleButtonPressed(String key) {
    setState(() {
      switch (key) {
        case '=':
          if (str != '' && !getAns) {
            str += '=${ReversePolish(str).getAns()}';
            getAns = true;
          }
          break;
        case '←':
          if (str.length > 0) {
            str = str.substring(0, str.length - 1);
            getAns = false;
          }
          break;
        default:
          if (getAns) {
            str = '';
            getAns = false;
          }
          str += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[300],
          title: Text('计算器'),
          textTheme: Theme.of(context).primaryTextTheme,
        ),
        body: Center(
          child: Column(children: [
            Expanded(
              child: Center(
                child: Text(
                  str,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Row(children: [
              baseButton(
                '(',
                onPressed: handleButtonPressed,
              ),
              baseButton(
                ')',
                onPressed: handleButtonPressed,
              ),
              baseButton(
                '%',
                onPressed: handleButtonPressed,
              ),
              baseButton(
                '/',
                onPressed: handleButtonPressed,
              ),
            ]),
            Row(children: [
              for (int i = 7; i < 10; i++)
                baseButton(
                  '$i',
                  onPressed: handleButtonPressed,
                ),
              baseButton(
                '*',
                onPressed: handleButtonPressed,
              ),
            ]),
            Row(children: [
              for (int i = 4; i < 7; i++)
                baseButton(
                  '$i',
                  onPressed: handleButtonPressed,
                ),
              baseButton(
                '-',
                onPressed: handleButtonPressed,
              ),
            ]),
            Row(children: [
              for (int i = 1; i < 4; i++)
                baseButton(
                  '$i',
                  onPressed: handleButtonPressed,
                ),
              baseButton(
                '+',
                onPressed: handleButtonPressed,
              ),
            ]),
            Row(children: [
              baseButton(
                '←',
                onPressed: handleButtonPressed,
                onLongpress: () {
                  setState(() {
                    str = '';
                  });
                },
              ),
              baseButton(
                '0',
                onPressed: handleButtonPressed,
              ),
              baseButton(
                '.',
                onPressed: handleButtonPressed,
              ),
              baseButton(
                '=',
                onPressed: handleButtonPressed,
              ),
            ])
          ]),
        ));
  }
}

typedef void onButtonPress(String str);

class baseButton extends StatelessWidget {
  final String name;
  final onButtonPress? onPressed;
  final void Function()? onLongpress;
  baseButton(this.name, {this.onPressed, this.onLongpress});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        heightFactor: 1.2,
        child: TextButton(
          onPressed: () {
            if (this.onPressed != null) {
              this.onPressed!(name);
            }
          },
          onLongPress: onLongpress,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red[200],
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  color: Colors.blueGrey[100] ?? Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.cyan[50],
            ),
            overlayColor: MaterialStateProperty.all(
              Colors.blue[30],
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(20),
            ),
            fixedSize: MaterialStateProperty.all(
              Size(90, 60),
            ),
          ),
        ),
      ),
    );
  }
}
