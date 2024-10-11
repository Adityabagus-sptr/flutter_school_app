import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifikasiAktif = true;
  String _bahasaTerpilih = 'Indonesia';
  bool _modeMalamAktif = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Notifikasi'),
            trailing: Switch(
              value: _notifikasiAktif,
              onChanged: (bool value) {
                setState(() {
                  _notifikasiAktif = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Bahasa'),
            subtitle: Text(_bahasaTerpilih),
            onTap: () {
              _pilihBahasa();
            },
          ),
          ListTile(
            title: Text('Mode Malam'),
            trailing: Switch(
              value: _modeMalamAktif,
              onChanged: (bool value) {
                setState(() {
                  _modeMalamAktif = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Tentang Aplikasi'),
            onTap: () {
              _tampilkanTentangAplikasi();
            },
          ),
        ],
      ),
    );
  }

  void _pilihBahasa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Bahasa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Indonesia'),
                onTap: () {
                  setState(() {
                    _bahasaTerpilih = 'Indonesia';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('English'),
                onTap: () {
                  setState(() {
                    _bahasaTerpilih = 'English';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _tampilkanTentangAplikasi() {
    showAboutDialog(
      context: context,
      applicationName: 'Aplikasi Sekolah',
      applicationVersion: '1.0.0',
      applicationIcon: FlutterLogo(size: 50),
      children: [
        Text('Aplikasi ini dikembangkan untuk memudahkan siswa dalam mengakses informasi sekolah.'),
      ],
    );
  }
}
