import 'package:flutter/material.dart';

class ShlokaCard extends StatelessWidget {
  const ShlokaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFBE8A6),
            const Color(0xFFFBE8A6).withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shloka of the day',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'यदा यदा हि धर्मस्य ग्लानिर्भवति भारत\nअभ्युत्थानमधर्मस्य तदात्मानं सृजाम्यहम्',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Whenever there is a decline in righteousness and a rise in unrighteousness, O Arjuna, I manifest Myself personally to protect the good and destroy the wicked.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Read Verse',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 16, color: Colors.black87),
            ],
          ),
        ],
      ),
    );
  }
}
