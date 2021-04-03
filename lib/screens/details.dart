import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Details extends StatefulWidget {
  final BluetoothDevice bluetoothDevice;

  const Details({Key key, this.bluetoothDevice}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _getDeviceName() {
    return widget.bluetoothDevice.name != ''
        ? widget.bluetoothDevice.name
        : widget.bluetoothDevice.id.toString();
  }

  bool _hasDeviceName() {
    return widget.bluetoothDevice.name != '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getDeviceName()}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${_hasDeviceName() ? widget.bluetoothDevice.name : "No Device Name"}',
            ),
            Text(
              'MAC Address: ${_getDeviceName()}',
            ),
          ],
        ),
      ),
    );
  }
}
