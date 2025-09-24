import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget that will be started on the application startup
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // Set counter value
  int _counter = 0;

  // Method to determine counter color based on value
  Color _getCounterColor() {
    if (_counter == 0) {
      return Colors.red; // Red when exactly 0
    } else if (_counter == 100) {
      return Colors.yellow; // Yellow for maximum liftoff value
    } else if (_counter > 50) {
      return Colors.green; // Green when above 50
    } else {
      return Colors.orange; // Orange for values between 1 and 50
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      // Set up the widget alignment
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    // To displays current number
                    '$_counter',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: _getCounterColor(), // Dynamic color based on value
                    ),
                  ),
                  // Show LIFTOFF message when counter reaches 100
                  if (_counter == 100)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '🚀 LIFTOFF! 🚀',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          const SizedBox(height: 20), // Add some spacing
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_counter < 100) { // Prevent going over max value
                  _counter++;
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('🚀 IGNITE'),
          ),
          const SizedBox(height: 15), // Spacing between button rows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter > 0) { // Prevent going below 0
                      _counter--;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('⛔ ABORT'),
              ),
              const SizedBox(width: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 0; // Reset to 0 immediately
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('🔄 RESET'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
