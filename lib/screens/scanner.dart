import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Scanner extends StatefulWidget {
  final List<BluetoothDevice> bluetoothDevices = <BluetoothDevice>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  void initState() {
    super.initState();

    _scanBluetooth();
  }

  void _scanBluetooth() {
    widget.flutterBlue.startScan(
      timeout: Duration(
        seconds: 5,
      ),
    );

    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult r in results) {
        print('Found!!!! ${r.device.id} found! rssi: ${r.rssi}');
      }
    });

    widget.flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blue Scan'),
        backgroundColor: Colors.blue.shade900,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scan',
        child: Icon(
          Icons.search,
        ),
        backgroundColor: Colors.blue.shade900,
        onPressed: () => print('ola'),
      ),
    );
    ;
  }
}
