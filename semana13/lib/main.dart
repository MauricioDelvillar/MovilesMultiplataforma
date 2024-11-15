import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendarios y Segmentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedSegment = 0; // Para el SegmentControl

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendarios y Segmentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Segment Control para Material y Cupertino
            CupertinoSegmentedControl<int>(
              children: const <int, Widget>{
                0: Text('Material'),
                1: Text('Cupertino'),
              },
              groupValue: _selectedSegment,
              onValueChanged: (int newValue) {
                setState(() {
                  _selectedSegment = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            // Texto que muestra la fecha seleccionada
            Text(
              'Fecha seleccionada: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Mostrar el componente correcto basado en el segmento seleccionado
            if (_selectedSegment == 0) _buildMaterialDatePicker(),
            if (_selectedSegment == 1) _buildCupertinoDatePicker(context),
          ],
        ),
      ),
    );
  }

  // Calendario y DatePicker para Material
  Widget _buildMaterialDatePicker() {
    return ElevatedButton(
      onPressed: () => _selectMaterialDate(context),
      child: Text('Mostrar Material DatePicker'),
    );
  }

  // Función para mostrar el DatePicker de Material
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // DatePicker para Cupertino
  Widget _buildCupertinoDatePicker(BuildContext context) {
    return CupertinoButton(
      child: Text('Mostrar Cupertino DatePicker'),
      onPressed: () => _showCupertinoDatePicker(context),
    );
  }

  // Función para mostrar el DatePicker de Cupertino
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
              CupertinoButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
