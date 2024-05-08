import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'Unknown';
    final password = prefs.getString('password') ?? 'Unknown';
    final dob = prefs.getString('dob') ?? 'Unknown';

    return {
      'Email': email,
      'Password': '******', // Sembunyikan kata sandi
      'Tanggal Lahir': dob,
    };
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus data saat logout
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor:
            Colors.blueGrey[700], // Warna gelap untuk kesan profesional
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, String>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data ?? {};

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blueGrey[700]),
                            SizedBox(width: 10),
                            Text('Email: ${userData['Email']}'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.lock, color: Colors.blueGrey[700]),
                            SizedBox(width: 10),
                            Text(
                                'Password: ${userData['Password']}'), // Dengan bintang-bintang
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.cake, color: Colors.blueGrey[700]),
                            SizedBox(width: 10),
                            Text('Tanggal Lahir: ${userData['Tanggal Lahir']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _logout(context),
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
