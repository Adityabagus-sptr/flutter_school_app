import 'package:flutter/material.dart';

class NilaiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nilai'),
      ),
      body: ListView(
        children: [
          _buildNilaiCard('Matematika', 85),
          _buildNilaiCard('Bahasa Indonesia', 90),
          _buildNilaiCard('Bahasa Inggris', 88),
          _buildNilaiCard('IPA', 92),
          _buildNilaiCard('IPS', 87),
          _buildNilaiCard('PPKn', 89),
          _buildNilaiCard('Seni Budaya', 95),
          _buildNilaiCard('Penjaskes', 93),
        ],
      ),
    );
  }

  Widget _buildNilaiCard(String mataPelajaran, int nilai) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(mataPelajaran),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getWarnaLatar(nilai),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            nilai.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getWarnaLatar(int nilai) {
    if (nilai >= 90) return Colors.green;
    if (nilai >= 80) return Colors.blue;
    if (nilai >= 70) return Colors.orange;
    return Colors.red;
  }
}
