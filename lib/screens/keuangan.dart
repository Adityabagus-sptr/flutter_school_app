import 'package:flutter/material.dart';

class KeuanganScreen extends StatelessWidget {
  const KeuanganScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keuangan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fitur Keuangan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menambah pemasukan
              },
              child: Text('Tambah Pemasukan'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menambah pengeluaran
              },
              child: Text('Tambah Pengeluaran'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk melihat laporan keuangan
              },
              child: Text('Lihat Laporan Keuangan'),
            ),
          ],
        ),
      ),
    );
  }
}
