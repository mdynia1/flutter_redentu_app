import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:redentuapp/widgets/rounded_button.dart';

class QrScreen extends StatefulWidget {
  static const id = 'QrScreen';
  @override
  QrScreenState createState() => QrScreenState();
}

class QrScreenState extends State<QrScreen> {
  String qrString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (String qr) {
                  qrString = qr;
                },
              ),
              RoundedButton(
                onPressed: () {
                  setState(() {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  });
                },
                title: 'Generate',
                colour: Colors.black54,
              ),
              QrImage(
                data: qrString,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
