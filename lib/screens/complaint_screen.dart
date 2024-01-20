import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ComplainScreen extends StatefulWidget {
  @override
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedComplaint = 'Choose a complaint'; // Default complaint type
  List<String> predefinedComplaints = [
    'Choose a complaint',
    'Obstacle',
    'Miss Parked Vehicle',
    'Pothole',
    'Miss Tag Parking Lot',
    'Other'
  ];

  String selectedFloor = 'Choose a floor'; // Default floor
  List<String> predefinedFloors = [
    'Choose a floor',
    'Floor 1',
    'Floor 2',
    'Floor 3',
  ];

  String selectedLot = 'Choose a parking lot'; // Default lot
  List<String> predefinedLots = [
    'Choose a parking lot',
    'A1',
    'A2',
    'A3',
    'A4',
    'B1',
    'B2',
    'B3',
    'B4',
    'C1',
    'C2',
    'C3',
    'C4',
  ];

  TextEditingController specificComplaintController = TextEditingController();

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: const Text(
            'Your Complaint Successfully Received',
            textAlign: TextAlign.center,
          ),
          actions: [
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                  );
                },
                child: const Text('Proceed to Dashboard'),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _saveComplaint() async {
    final url = Uri.https(
        'flutterparkingapp-fcc61-default-rtdb.asia-southeast1.firebasedatabase.app',
        'Complaints.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'complaintType': selectedComplaint,
          'specificComplaint': specificComplaintController.text,
          'selectedFloor': selectedFloor,
          'selectedLot': selectedLot,
          'name': nameController.text,
          'phoneNumber': phoneController.text,
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

    // Show the confirmation dialog.
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
            'File a Complaint',
            style: TextStyle(
                color: Color(0xFF090A0D), fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      children: [
                        ListTile(
                          title: const Text("Complaint Type"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: false,
                              value: selectedComplaint,
                              items: predefinedComplaints.map((floor) {
                                return DropdownMenuItem(
                                  value: floor,
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      floor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedComplaint = value.toString();
                                });
                              },
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  "Select Floor",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        if (selectedComplaint == 'Other')
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Specify Complaint:'),
                                TextField(
                                  controller: specificComplaintController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter specific complaint...',
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
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
                      children: [
                        ListTile(
                          title: const Text("Floor"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: false,
                              value: selectedFloor,
                              items: predefinedFloors.map((floor) {
                                return DropdownMenuItem(
                                  value: floor,
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      floor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedFloor = value.toString();
                                });
                              },
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  "Select Floor",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text("Parking Lot"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: false,
                              value: selectedLot,
                              items: predefinedLots.map((floor) {
                                return DropdownMenuItem(
                                  value: floor,
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      floor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedLot = value.toString();
                                });
                              },
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  "Select Parking Lot",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      children: [
                        const Text('Your Name:'),
                        // const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your name...',
                            ),
                          ),
                        ),
                        const Text('Your Phone Number:'),
                        // const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number...',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 50),
                        backgroundColor: Colors.orange,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    onPressed: _saveComplaint,
                    child: const Text(
                      'Submit Complaint',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
