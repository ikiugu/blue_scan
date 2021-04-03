import 'package:blue_scan/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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

  _addTolist(final ScanResult scanResult) {
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
        return ListTile(
          leading: Icon(
            Icons.bluetooth,
            color: Colors.blue.shade900,
          ),
          title: Text(
            widget.scanResults[index].device.name != ''
                ? widget.scanResults[index].device.name
                : widget.scanResults[index].device.id.toString(),
          ),
          subtitle: Text('RSSI: ${widget.scanResults[index].rssi}'),
          onTap: () {
            _navigateToSecondScreen(index: index);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: .0,
        );
      },
      shrinkWrap: true,
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
        _addTolist(result);
      }
    });

    widget.flutterBlue.stopScan();
  }

  void _navigateToSecondScreen({int index}) {
    ScanResult scanResult = widget.scanResults[index];
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(
        bluetoothDevice: scanResult.device,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blue Scan'),
      ),
      body: _buildListViewOfDevices(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scan',
        child: Icon(
          Icons.search,
        ),
        onPressed: () => _scanBluetooth(),
      ),
    );
    ;
  }
}
