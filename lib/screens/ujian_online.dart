import 'package:flutter/material.dart';

class UjianOnlineScreen extends StatefulWidget {
  @override
  _UjianOnlineScreenState createState() => _UjianOnlineScreenState();
}

class _UjianOnlineScreenState extends State<UjianOnlineScreen> {
  List<Ujian> daftarUjian = [
    Ujian(
      mataPelajaran: 'Matematika',
      tanggal: DateTime(2023, 6, 15),
      waktuMulai: TimeOfDay(hour: 8, minute: 0),
      durasi: Duration(hours: 2),
    ),
    Ujian(
      mataPelajaran: 'Bahasa Indonesia',
      tanggal: DateTime(2023, 6, 17),
      waktuMulai: TimeOfDay(hour: 10, minute: 30),
      durasi: Duration(hours: 1, minutes: 30),
    ),
    // Tambahkan ujian lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ujian Online'),
      ),
      body: ListView.builder(
        itemCount: daftarUjian.length,
        itemBuilder: (context, index) {
          return _buildUjianCard(daftarUjian[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _tambahUjian(context);
        },
      ),
    );
  }

  Widget _buildUjianCard(Ujian ujian) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(ujian.mataPelajaran),
        subtitle: Text(
          'Tanggal: ${ujian.tanggal.toString().split(' ')[0]}\n'
          'Waktu: ${ujian.waktuMulai.format(context)}\n'
          'Durasi: ${ujian.durasi.inHours} jam ${ujian.durasi.inMinutes.remainder(60)} menit',
        ),
        trailing: ElevatedButton(
          child: Text('Mulai'),
          onPressed: () {
            _mulaiUjian(context, ujian);
          },
        ),
      ),
    );
  }

  void _tambahUjian(BuildContext context) {
    // Implementasi penambahan ujian baru
    // Anda dapat menambahkan form input di sini
  }

  void _mulaiUjian(BuildContext context, Ujian ujian) {
    // Implementasi untuk memulai ujian
    // Anda dapat menambahkan navigasi ke halaman ujian di sini
  }
}

class Ujian {
  final String mataPelajaran;
  final DateTime tanggal;
  final TimeOfDay waktuMulai;
  final Duration durasi;

  Ujian({
    required this.mataPelajaran,
    required this.tanggal,
    required this.waktuMulai,
    required this.durasi,
  });
}
