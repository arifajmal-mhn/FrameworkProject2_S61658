import 'package:flutter/material.dart';
import 'parking_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChooseLotScreen extends StatefulWidget {
  final int floor;
  final String section;

  ChooseLotScreen({required this.floor, required this.section});

  @override
  _ChooseLotScreenState createState() => _ChooseLotScreenState();
}

class _ChooseLotScreenState extends State<ChooseLotScreen> {
  Map<String, bool> lotAvailability = {};

  @override
  void initState() {
    super.initState();
    _loadLotAvailability();
  }

  Future<void> _loadLotAvailability() async {
    final url = Uri.https(
      'flutterparkingapp-fcc61-default-rtdb.asia-southeast1.firebasedatabase.app',
      'floors/${widget.floor - 1}/sections/${widget.section}.json', // Adjust indexing
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data != null) {
          print('Raw Data: $data');

          setState(() {
            lotAvailability = Map<String, bool>.from(data);
          });

          print('Parsed Availability: $lotAvailability');
        } else {
          print('Error: Response body is null.');
        }
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
        throw Exception('Failed to load parking lot availability');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void navigateToParkingDetails(String lotName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParkingDetailsScreen(
          floor: widget.floor.toString(),
          section: widget.section,
          lotName: lotName,
          parkingRate: 3.00,
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
        title: Text(
          'Choose Lot - Floor ${widget.floor}, Section ${widget.section}',
          style: const TextStyle(
            color: Color(0xFF090A0D),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (int i = 1; i <= 4; i++)
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.orange, // Customize the color here
                    child: ListTile(
                      title: Text(
                        '${widget.section}$i',
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      subtitle: lotAvailability
                              .containsKey('${widget.section}$i')
                          ? Text(
                              lotAvailability['${widget.section}$i'] == true
                                  ? 'Available'
                                  : 'Booked',
                              style: TextStyle(
                                  color:
                                      lotAvailability['${widget.section}$i'] ==
                                              true
                                          ? Colors.green
                                          : Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )
                          : null,
                      onTap: () {
                        if (lotAvailability
                                .containsKey('${widget.section}$i') &&
                            lotAvailability['${widget.section}$i'] == true) {
                          navigateToParkingDetails('${widget.section}$i');
                        } else {
                          // Show a message or take appropriate action for an unavailable lot
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              title: const Text(
                                'Parking Lot Already Booked',
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'images/xmark.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  const Text(
                                      'The selected parking lot is already booked. You can choose other available parking lot.'),
                                ],
                              ),
                              actions: [
                                Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Add spacing between lots
              ],
            ),
        ],
      ),
    );
  }
}
