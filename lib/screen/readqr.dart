import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var result = 'Scan it';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning QR code '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                result,
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
              ElevatedButton(
                  onPressed:scanQr,
                  child: const Text('Scanner')),
              SizedBox(
                height: screenhight,
                width: screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>scanQr()async{
    try{
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value) => {
        setState((){
          result=value;
        })
      });
    }catch(e){
      setState(() {
        result='unable to read this';
      });
    }
  }
}
