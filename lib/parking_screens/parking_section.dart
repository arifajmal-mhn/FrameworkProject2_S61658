import 'package:flutter/material.dart';
import 'parking_lot.dart';

class ChooseSectionScreen extends StatelessWidget {
  final int floor;

  ChooseSectionScreen({required this.floor});

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
          'Choose Section - Floor $floor',
          style: const TextStyle(
            color: Color(0xFF090A0D),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (String section in ['A', 'B', 'C'])
            Column(
              children: [
                ListTile(
                  title: Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.82,
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
                      color: Colors.orange, // Change the color here
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseLotScreen(
                                floor: floor,
                                section: section,
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Section $section',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Add spacing between sections
              ],
            ),
        ],
      ),
    );
  }
}
