import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptScreen extends StatelessWidget {
  final String lotName;
  final double parkingRate;
  final int parkingDuration;
  final double? totalPayment;
  final DateTime transactionDate;

  ReceiptScreen({
    required this.lotName,
    required this.parkingRate,
    required this.parkingDuration,
    this.totalPayment,
    required this.transactionDate,
  });

  @override
  Widget build(BuildContext context) {
    // Format date and time
    String formattedDate = DateFormat('dd/MM/yyyy').format(transactionDate);
    String formattedTime = DateFormat('h:mm a').format(transactionDate);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF090A0D),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Parking Receipt',
          style:
              TextStyle(color: Color(0xFF090A0D), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            const Text(
              'Thank you for parking with us!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Parking Lot and Rate Card
            _buildCard(
              context,
              'Parking Lot',
              '$lotName',
              'Parking Rate',
              'RM ${parkingRate.toStringAsFixed(2)} per hour',
            ),

            const SizedBox(height: 10),

            // Duration and Date Card
            _buildCard(
              context,
              'Duration',
              '$parkingDuration hour${parkingDuration > 1 ? 's' : ''}',
              'Date',
              '$formattedDate at $formattedTime',
            ),

            const SizedBox(height: 10),

            // Separator Line
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),

            // Total Payment Card
            _buildCard(
              context,
              'Total Payment',
              'RM ${totalPayment?.toStringAsFixed(2)}',
              null,
              null,
            ),

            const SizedBox(height: 20),

            // Footer
            const Text(
              'Please come again!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a custom card
  Widget _buildCard(
    BuildContext context,
    String title1,
    String content1,
    String? title2,
    String? content2,
  ) {
    return Card(
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
            Text(
              title1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content1,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (title2 != null && content2 != null) ...[
              const SizedBox(height: 16),
              Text(
                title2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
