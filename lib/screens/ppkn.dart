import 'package:flutter/material.dart';

class PPKNScreen extends StatelessWidget {
  const PPKNScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPKN'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            'Pancasila',
            'Pelajari dasar negara Indonesia',
            Icons.flag,
          ),
          _buildSectionCard(
            'UUD 1945',
            'Pahami konstitusi negara',
            Icons.book,
          ),
          _buildSectionCard(
            'Hak dan Kewajiban Warga Negara',
            'Pelajari hak dan kewajiban sebagai warga negara',
            Icons.people,
          ),
          _buildSectionCard(
            'Sistem Pemerintahan',
            'Pelajari struktur dan fungsi pemerintahan',
            Icons.account_balance,
          ),
          _buildSectionCard(
            'Wawasan Nusantara',
            'Pahami konsep persatuan dan kesatuan bangsa',
            Icons.public,
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
          backgroundColor: Colors.red,
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
