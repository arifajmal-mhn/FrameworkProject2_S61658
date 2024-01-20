import 'package:flutter/material.dart';
import '../parking_screens/parking_floor.dart';
import 'complaint_screen.dart';
import 'receipt_screen.dart';
import 'details_screen.dart';

class DashboardScreen extends StatelessWidget {
  final int? selectedDuration;
  final String? selectedLot;
  final String? plateNumber;
  final double? totalPayment;

  DashboardScreen({
    this.selectedDuration,
    this.selectedLot,
    this.plateNumber,
    this.totalPayment,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.4;
    double cardHeight = MediaQuery.of(context).size.height * 0.17;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF090A0D),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style:
              TextStyle(color: Color(0xFF090A0D), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: cardWidth,
                  height: cardHeight,
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
                            'Duration',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${selectedDuration ?? 0} hour${selectedDuration != 1 ? 's' : ''}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: cardWidth,
                  height: cardHeight,
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
                            'Parking Lot',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            selectedLot ?? '',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
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
              width: MediaQuery.of(context).size.width * 0.82,
              height: 120,
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
                        'Plate Number',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        plateNumber ?? '',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.82,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseFloorScreen()),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Book a Parking Lot",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  backgroundColor: Colors.orange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
                // child: const Text(
                //   'Book a Parking Lot',
                //   style: TextStyle(fontSize: 18),
                // ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.82,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplainScreen()),
                  );
                },
                icon: const Icon(Icons.report),
                label: const Text(
                  "File a Complaint",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  backgroundColor: Colors.orange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
                // child: const Text(
                //   'File a Complaint',
                //   style: TextStyle(fontSize: 18),
                // ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.82,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptScreen(
                        lotName: selectedLot ?? '',
                        parkingRate: 3.00,
                        parkingDuration: selectedDuration ?? 0,
                        totalPayment: totalPayment ?? 0.00,
                        transactionDate: DateTime.now(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.receipt_long),
                label: const Text(
                  "Your Receipt",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  backgroundColor: Colors.orange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
                // child: const Text(
                //   'Your Receipt',
                //   style: TextStyle(fontSize: 18),
                // ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.82,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewParkingDetailsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.help),
                label: const Text(
                  "About Parking Facility",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  backgroundColor: Colors.orange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
                // child: const Text(
                //   'About Parking Facility',
                //   style: TextStyle(fontSize: 18),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
