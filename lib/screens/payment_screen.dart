import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final String floor;
  final String lotName;
  final double parkingRate;
  final int parkingDuration;
  final String plateNumber;

  PaymentScreen({
    required this.floor,
    required this.lotName,
    required this.parkingRate,
    required this.parkingDuration,
    required this.plateNumber,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  late double totalPayment;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    calculateTotalPayment();
  }

  void calculateTotalPayment() {
    totalPayment = widget.parkingRate * widget.parkingDuration;
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: const Text(
            'Parking Lot Booked Successfully',
            textAlign: TextAlign.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  'images/verified.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 26),
              Text('Your Parking Lot: ${widget.lotName}'),
              Text('Plate Number: ${widget.plateNumber}'),
              Text('Total Payment: RM${totalPayment.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center, // Align the button to the center
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          selectedDuration: widget.parkingDuration,
                          selectedLot: 'F${widget.floor} - ${widget.lotName}',
                          plateNumber: widget.plateNumber,
                          totalPayment: totalPayment,
                        ),
                      ),
                    );
                  },
                  child: const Text('Proceed to Home'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _savePaymentInformation() async {
    final url = Uri.https(
        'flutterparkingapp-fcc61-default-rtdb.asia-southeast1.firebasedatabase.app',
        'Payments.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'lotName': widget.lotName,
          'plateNumber': widget.plateNumber,
          'parkingRate': widget.parkingRate,
          'parkingDuration': widget.parkingDuration,
          'totalPayment': totalPayment,
          'fullName': fullNameController.text,
          'billingAddress': billingAddressController.text,
          'cardNumber': cardNumberController.text,
          'expiryDate': expiryDateController.text,
          'cvv': cvvController.text,
        },
      ),
    );

    print(response.body);
    print(response.statusCode);

    if (!context.mounted) {
      return;
    }

    showConfirmationDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF090A0D),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Payment Information',
          style:
              TextStyle(color: Color(0xFF090A0D), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Parking Lot: ${widget.lotName}'),
                // Text('Plate Number: ${widget.plateNumber}'),
                // const SizedBox(height: 16),
                // Text(
                //     'Parking Rate: RM ${widget.parkingRate.toStringAsFixed(2)} per hour'),
                // Text(
                //     'Duration: ${widget.parkingDuration} hour${widget.parkingDuration > 1 ? 's' : ''}'),
                // const SizedBox(height: 16),
                // Text('Total Payment: RM ${totalPayment.toStringAsFixed(2)}'),
                // const SizedBox(height: 16),
                // const Text('Enter Payment Information:'),
                // const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Parking Lot',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'F${widget.floor} - ${widget.lotName}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Plate Number',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${widget.plateNumber}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Parking Rate',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'RM${widget.parkingRate.toStringAsFixed(2)} per hour',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Duration',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${widget.parkingDuration} hour${widget.parkingDuration > 1 ? 's' : ''}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Total Payment',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'RM${totalPayment.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --------------------------------------
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Enter Payment Information:'),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: fullNameController,
                          decoration:
                              const InputDecoration(labelText: 'Full Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: billingAddressController,
                          decoration: const InputDecoration(
                              labelText: 'Billing Address'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your billing address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: cardNumberController,
                          decoration: const InputDecoration(
                              labelText: 'Credit Card Number'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your credit card number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: expiryDateController,
                          decoration: const InputDecoration(
                              labelText: 'Expiry Date (MM/YY)'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the expiry date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: cvvController,
                          decoration: const InputDecoration(labelText: 'CVV'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the CVV';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //----------------------------------------------------

                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: Colors.orange,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _savePaymentInformation();
                    }
                  },
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
