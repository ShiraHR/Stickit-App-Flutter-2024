import 'dart:math';
import 'package:flutter/material.dart';
import '../components/header.dart';

class BorderPage extends StatelessWidget {
  final int currentIndex;
  final int boardLength;
  final int borderNumber;

  const BorderPage({
    super.key,
    required this.currentIndex,
    required this.boardLength,
    required this.borderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 248, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 248, 244),
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            children: [
              Header(title: 'אלבום #$borderNumber'),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sqrt(boardLength).floor(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: boardLength,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: index < currentIndex ? Colors.green : Colors.white,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: index < currentIndex ? Colors.white : Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}