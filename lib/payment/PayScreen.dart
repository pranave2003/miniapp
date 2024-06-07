import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class UpiPaymentScreen extends StatefulWidget {
  const UpiPaymentScreen({super.key, required this.price});
  final price;
  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    super.initState();
    _fetchUpiApps();
  }

  Future<void> _fetchUpiApps() async {
    List<UpiApp>? installedApps = await _upiIndia.getAllUpiApps();
    setState(() {
      apps = installedApps;
    });
  }

  Future<void> _initiateTransaction(UpiApp app) async {
    UpiResponse response = await _upiIndia.startTransaction(
      app: app,
      receiverUpiId:
          "vaishnavedakkattu@okaxis", // Replace with the actual UPI ID
      receiverName: "Vaishnav",
      transactionRefId: "TransactionID",
      transactionNote: "Payment for MD Store",
      amount: widget.price,
    );

    print(response);
    _showTransactionStatus(response);
  }

  void _showTransactionStatus(UpiResponse response) {
    String status;
    switch (response.status) {
      case UpiPaymentStatus.SUCCESS:
        status = "Transaction Successful";
        break;
      case UpiPaymentStatus.SUBMITTED:
        status = "Transaction Submitted";
        break;
      case UpiPaymentStatus.FAILURE:
        status = "Transaction Failed";
        break;
      default:
        status = "Unknown Status";
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Status'),
          content: Text(status),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment Integration'),
      ),
      body: apps == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: apps!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.memory(
                    apps![index].icon,
                    height: 40,
                    width: 40,
                  ),
                  title: Text(apps![index].name),
                  onTap: () => _initiateTransaction(apps![index]),
                );
              },
            ),
    );
  }
}
