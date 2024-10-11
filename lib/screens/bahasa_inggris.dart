import 'package:flutter/material.dart';

class BahasaInggrisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bahasa Inggris'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Tata Bahasa',
            'Pelajari struktur dan aturan bahasa Inggris',
            Icons.book,
          ),
          _buildSectionCard(
            'Kosakata',
            'Tingkatkan perbendaharaan kata Anda',
            Icons.translate,
          ),
          _buildSectionCard(
            'Membaca',
            'Latihan pemahaman bacaan',
            Icons.menu_book,
          ),
          _buildSectionCard(
            'Menulis',
            'Kembangkan keterampilan menulis Anda',
            Icons.edit,
          ),
          _buildSectionCard(
            'Berbicara',
            'Latihan pengucapan dan percakapan',
            Icons.record_voice_over,
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
          backgroundColor: Colors.purple,
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
