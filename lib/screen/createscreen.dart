import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var qrstr = 'Add Data';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double hightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creating QR code '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BarcodeWidget(
              data: qrstr,
              barcode: Barcode.qrCode(),
              color: Colors.blue,
              height: 250,
              width: 250,
            ),
            SizedBox(
             height: hightWidth/10,
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      qrstr = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your data here',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2))),
                )),
            SizedBox(
              width: screenWidth,
            )
          ],
        ),
      ),
    );
  }
}
