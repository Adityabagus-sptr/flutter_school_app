import 'package:flutter_school_app/screens/Jadwal_pelajaran.dart';
import 'package:flutter/material.dart';
import 'matematika.dart';
import 'bahasa_indonesia.dart';
import 'bahasa_inggris.dart';
import 'ipa.dart';
import 'ips.dart';
import 'ppkn.dart';
import 'seni_budaya.dart';
import 'penjaskes.dart';
import 'profil.dart';
import 'login.dart';
import 'tugas.dart';
import 'nilai.dart';
import 'absensi.dart';
import 'ujian_online.dart';
import 'ekstrakurikuler.dart';
import 'keuangan.dart';
import 'settings.dart'; // Impor halaman pengaturan

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[50],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://example.com/header_image.jpg'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROdnCE-Yz4Y3OR6xyyg60N_UU2g37nwr-X5avJPZ6G9fjjUxaPRURZm1qhx1wG1_e1-cw&usqp=CAU'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aditya Bagus Saputra',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'aditya@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.blue),
                title: Text('Beranda', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.blue),
                title: Text('Pengaturan', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi Logout'),
                        content: Text('Apakah Anda yakin ingin keluar?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROdnCE-Yz4Y3OR6xyyg60N_UU2g37nwr-X5avJPZ6G9fjjUxaPRURZm1qhx1wG1_e1-cw&usqp=CAU'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat datang kembali,',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Aditya Bagus Saputra',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hari ini!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Kelas dimulai pukul 09:00'),
                  ],
                ),
                Icon(Icons.calendar_today, color: Colors.blue),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Fitur Lainnya',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFeatureCard(context, 'Jadwal Pelajaran', Icons.schedule, JadwalPelajaranScreen()),
                _buildFeatureCard(context, 'Tugas', Icons.assignment, TugasScreen()),
                _buildFeatureCard(context, 'Nilai', Icons.grade, NilaiScreen()),
                _buildFeatureCard(context, 'Absensi', Icons.how_to_reg, AbsensiScreen()),
                _buildFeatureCard(context, 'Ujian Online', Icons.computer, UjianOnlineScreen()),
                _buildFeatureCard(context, 'Ekstrakurikuler', Icons.sports_soccer, EkstrakurikulerScreen()),
                _buildFeatureCard(context, 'Keuangan', Icons.attach_money, KeuanganScreen()),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Mata Pelajaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildMenuCard(context, 'Matematika', 'Belajar angka dan logika', Colors.blue, MatematikaScreen()),
                _buildMenuCard(context, 'Bahasa Indonesia', 'Belajar bahasa nasional', Colors.red, BahasaIndonesiaScreen()),
                _buildMenuCard(context, 'Bahasa Inggris', 'Belajar bahasa internasional', Colors.purple, BahasaInggrisScreen()),
                _buildMenuCard(context, 'IPA', 'Ilmu Pengetahuan Alam', Colors.green, IPAScreen()),
                _buildMenuCard(context, 'IPS', 'Ilmu Pengetahuan Sosial', Colors.orange, IPSScreen()),
                _buildMenuCard(context, 'PPKn', 'Pendidikan Pancasila dan Kewarganegaraan', Colors.red, PPKNScreen()),
                _buildMenuCard(context, 'Seni Budaya', 'Eksplorasi seni dan budaya', Colors.pink, SeniBudayaScreen()),
                _buildMenuCard(context, 'Penjaskes', 'Pendidikan Jasmani dan Kesehatan', Colors.teal, PenjaskesScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(right: 10),
        child: Container(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(height: 5),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, String description, Color color, Widget destination) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            Icons.book,
            color: Colors.white,
          ),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
