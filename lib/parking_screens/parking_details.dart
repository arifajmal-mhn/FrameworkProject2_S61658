import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/payment_screen.dart';

class ParkingDetailsScreen extends StatefulWidget {
  final String floor;
  final String section;
  final String lotName;
  final double parkingRate; // Parking rate per hour

  ParkingDetailsScreen({
    required this.floor,
    required this.section,
    required this.lotName,
    required this.parkingRate,
  });

  @override
  _ParkingDetailsScreenState createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  double selectedDuration = 1; // Default parking duration

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _saveParkingDetails() async {
    final url = Uri.https(
        'flutterparkingapp-fcc61-default-rtdb.asia-southeast1.firebasedatabase.app',
        'Parking-Details.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'floor': widget.floor,
          'section': widget.section,
          'lotName': widget.lotName,
          'parkingRate': widget.parkingRate,
          'selectedDuration': selectedDuration,
          'name': nameController.text,
          'phone': phoneController.text,
          'plateNumber': plateNumberController.text,
        },
      ),
    );

    // Check the data and status code.
    print(response.body);
    print(response.statusCode);

    // Check if the context for the widget is null.
    if (!context.mounted) {
      return;
    }

    // Navigate to the payment screen or perform any other action after saving data.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          floor: widget.floor.toString(),
          lotName: '${widget.lotName}',
          parkingRate: 3.00,
          parkingDuration: selectedDuration.round(),
          plateNumber: plateNumberController.text,
        ),
      ),
    );
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
          'Parking Details',
          style:
              TextStyle(color: Color(0xFF090A0D), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.82,
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
                        Text(
                          'Parking Lot: Floor ${widget.floor} - ${widget.lotName}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Parking Rate: RM${widget.parkingRate.toStringAsFixed(2)} per hour',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.82,
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
                          const Text(
                              'Choose Parking Duration (Use the slider to choose):'),
                          Slider(
                            value: selectedDuration,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            onChanged: (double value) {
                              setState(() {
                                selectedDuration = value;
                              });
                            },
                            label: selectedDuration.round().toString() +
                                ' hour${selectedDuration.round() > 1 ? 's' : ''}',
                          ),
                          Text(
                            'Selected Duration: ${selectedDuration.round()} hour${selectedDuration.round() > 1 ? 's' : ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.82,
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
                          TextFormField(
                            controller: nameController,
                            decoration:
                                const InputDecoration(labelText: 'Your Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter phone number (XXX-XXXXXXX)',
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              final RegExp phoneRegex =
                                  RegExp(r'^\d{3}-\d{7}$');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              } else if (!phoneRegex.hasMatch(value)) {
                                return 'Please enter a valid phone number (XXX-XXXXXXX)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: plateNumberController,
                            decoration: const InputDecoration(
                                labelText: 'Car Plate Number'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your car plate number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 50),
                        backgroundColor: Colors.orange,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveParkingDetails();
                      }
                    },
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
