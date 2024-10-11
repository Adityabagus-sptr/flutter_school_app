import 'package:flutter/material.dart';

class BahasaIndonesiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bahasa Indonesia'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Tata Bahasa',
            'Pelajari struktur dan aturan bahasa Indonesia',
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

  Widget _buildSectionCard(String title, String description, IconData icon) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Implementasi navigasi ke halaman detail materi
        },
      ),
    );
  }
}
