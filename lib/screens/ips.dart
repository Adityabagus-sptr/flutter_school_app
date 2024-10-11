import 'package:flutter/material.dart';

class IPSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ilmu Pengetahuan Sosial'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Sejarah',
            'Pelajari peristiwa penting masa lalu',
            Icons.history,
          ),
          _buildSectionCard(
            'Geografi',
            'Eksplorasi bumi dan lingkungan',
            Icons.public,
          ),
          _buildSectionCard(
            'Ekonomi',
            'Pelajari sistem ekonomi dan keuangan',
            Icons.attach_money,
          ),
          _buildSectionCard(
            'Sosiologi',
            'Pahami masyarakat dan interaksi sosial',
            Icons.people,
          ),
          _buildSectionCard(
            'Antropologi',
            'Pelajari kebudayaan manusia',
            Icons.diversity_3,
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
          backgroundColor: Colors.orange,
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
