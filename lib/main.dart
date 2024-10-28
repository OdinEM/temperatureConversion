import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _selectedConversion = 'F to C'; // Default conversion
  String _result = '';
  final List<String> _history = [];

  void _convertTemperature() {
    double inputTemperature = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemperature;

    if (_selectedConversion == 'F to C') {
      // Convert Fahrenheit to Celsius
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
      setState(() {
        _result = '${convertedTemperature.toStringAsFixed(2)} °C';
        _history.add('F to C: $inputTemperature => ${convertedTemperature.toStringAsFixed(2)}');
      });
    } else {
      // Convert Celsius to Fahrenheit
      convertedTemperature = (inputTemperature * 9 / 5) + 32;
      setState(() {
        _result = '${convertedTemperature.toStringAsFixed(2)} °F';
        _history.add('C to F: $inputTemperature => ${convertedTemperature.toStringAsFixed(2)}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('F to C'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _selectedConversion,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('C to F'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _selectedConversion,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
