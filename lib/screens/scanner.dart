import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

const TEXT_FONT_SIZE = 20.0;

class Scanner extends StatefulWidget {
  final List<ScanResult> scanResults = <ScanResult>[];
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

  _addDeviceTolist(final ScanResult scanResult) {
    if (!widget.scanResults.contains(scanResult)) {
      setState(() {
        widget.scanResults.add(scanResult);
      });
    }
  }

  ListView _buildListViewOfDevices() {
    return ListView.separated(
      itemCount: widget.scanResults.length,
      itemBuilder: (context, index) {
        return Container(
          height: 45.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.bluetooth),
              Text(
                widget.scanResults[index].device.name != ''
                    ? widget.scanResults[index].device.name
                    : widget.scanResults[index].device.id.toString(),
                style: TextStyle(fontSize: TEXT_FONT_SIZE),
              ),
              Text(
                'RSSI: ${widget.scanResults[index].rssi}',
                style: TextStyle(fontSize: TEXT_FONT_SIZE),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: .0,
        );
      },
    );
  }

  void _scanBluetooth() {
    widget.flutterBlue.startScan(
      timeout: Duration(
        seconds: 5,
      ),
    );

    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result);
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
      body: _buildListViewOfDevices(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scan',
        child: Icon(
          Icons.search,
        ),
        backgroundColor: Colors.blue.shade900,
        onPressed: () => _scanBluetooth(),
      ),
    );
    ;
  }
}
