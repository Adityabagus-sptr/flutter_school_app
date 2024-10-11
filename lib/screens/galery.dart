import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GaleryScreen extends StatefulWidget {
  @override
  _GaleryScreenState createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
  List<dynamic> galeryItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGaleryItems();
  }

  Future<void> fetchGaleryItems() async {
    try {
      final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery'));
      if (response.statusCode == 200) {
        setState(() {
          galeryItems = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Gagal memuat data galeri');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat memuat data galeri'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addGaleryItem(String judulGalery, String isiGalery, String tglPostGalery, String statusGalery, String kdPetugas) async {
    try {
      final response = await http.post(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery'),
        body: json.encode({
          'judul_galery': judulGalery,
          'isi_galery': isiGalery,
          'tgl_post_galery': tglPostGalery,
          'status_galery': statusGalery,
          'kd_petugas': kdPetugas
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchGaleryItems();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item galeri berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Gagal menambahkan item galeri');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat menambahkan item galeri'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> updateGaleryItem(String kdGalery, String judulGalery, String isiGalery, String tglPostGalery, String statusGalery, String kdPetugas) async {
    try {
      final response = await http.put(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery'),
        body: json.encode({
          'kd_galery': kdGalery,
          'judul_galery': judulGalery,
          'isi_galery': isiGalery,
          'tgl_post_galery': tglPostGalery,
          'status_galery': statusGalery,
          'kd_petugas': kdPetugas
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        fetchGaleryItems();
      } else {
        throw Exception('Gagal memperbarui item galeri');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat memperbarui item galeri'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteGaleryItem(String kdGalery) async {
    try {
      final response = await http.delete(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery&kd_galery=$kdGalery'),
      );
      if (response.statusCode == 200) {
        fetchGaleryItems();
      } else {
        throw Exception('Gagal menghapus item galeri');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat menghapus item galeri'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddGaleryDialog() {
    String judulGalery = '';
    String isiGalery = '';
    String statusGalery = 'Aktif';
    String kdPetugas = '1'; // Ganti dengan kode petugas yang sesuai

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Item Galeri'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Judul Galeri'),
                  onChanged: (value) => judulGalery = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'URL Gambar'),
                  onChanged: (value) => isiGalery = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                if (judulGalery.isNotEmpty && isiGalery.isNotEmpty) {
                  addGaleryItem(judulGalery, isiGalery, DateTime.now().toIso8601String(), statusGalery, kdPetugas);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Judul dan URL gambar harus diisi'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeri', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : galeryItems.isEmpty
              ? Center(child: Text('Tidak ada item galeri'))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: galeryItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(imageUrl: galeryItems[index]['isi_galery']),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(
                                galeryItems[index]['isi_galery'],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                galeryItems[index]['judul_galery'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGaleryDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
