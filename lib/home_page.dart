import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _activeTab = 'Home';

  void _onTabSelected(String tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Simple Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: NavigationDrawer(
        activeTab: _activeTab,
        onTabSelected: _onTabSelected,
      ),
      body: CalculatorBody(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabSelected;

  NavigationDrawer({required this.activeTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            isActive: activeTab == 'Home',
            onTap: () {
              onTabSelected('Home');
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: 'About',
            isActive: activeTab == 'About',
            onTap: () {
              onTabSelected('About');
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            isActive: false,
            onTap: () {
              signUserOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}

class CalculatorBody extends StatefulWidget {
  @override
  _CalculatorBodyState createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operator = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operator = buttonText;
        _currentInput = "";
      } else if (buttonText == ".") {
        if (_currentInput.contains(".")) {
          return;
        } else {
          _currentInput = _currentInput + buttonText;
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_currentInput);
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "x") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          _output = (_num1 / _num2).toString();
        }
        _num1 = 0.0;
        _num2 = 0.0;
        _operator = "";
        _currentInput = _output;
      } else {
        _currentInput = _currentInput + buttonText;
        _output = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              buildButtonRow(['7', '8', '9', '+']),
              buildButtonRow(['4', '5', '6', 'x']),
              buildButtonRow(['1', '2', '3', '-']),
              buildButtonRow(['0', '.', '=', '/']),
              buildButtonRow(['C'], singleButton: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, {bool singleButton = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonText) {
        Color buttonColor = ['+', 'x', '-', '/', '='].contains(buttonText)
            ? Colors.orange
            : (Colors.grey[850] ?? Colors.grey);
        return CalculatorButton(
          text: buttonText,
          textColor: Colors.white,
          backgroundColor: buttonColor,
          onPressed: () => _buttonPressed(buttonText),
          singleButton: singleButton,
        );
      }).toList(),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool singleButton;

  const CalculatorButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
    this.singleButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return singleButton
        ? Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  primary: backgroundColor,
                ),
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  primary: backgroundColor,
                ),
              ),
            ),
          );
  }
}
