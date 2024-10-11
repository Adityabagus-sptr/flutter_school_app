import 'package:flutter/material.dart';

class MatematikaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matematika'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Aritmetika',
            'Pelajari operasi dasar matematika',
            Icons.calculate,
          ),
          _buildSectionCard(
            'Aljabar',
            'Eksplorasi persamaan dan fungsi',
            Icons.functions,
          ),
          _buildSectionCard(
            'Geometri',
            'Pelajari bentuk dan ruang',
            Icons.architecture,
          ),
          _buildSectionCard(
            'Statistika',
            'Analisis data dan probabilitas',
            Icons.bar_chart,
          ),
          _buildSectionCard(
            'Trigonometri',
            'Pelajari sudut dan segitiga',
            Icons.change_history,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String judul, String deskripsi, IconData ikon) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(ikon, color: Colors.white),
        ),
        title: Text(
          judul,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(deskripsi),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Implementasi navigasi ke halaman detail materi
        },
      ),
    );
  }
}
