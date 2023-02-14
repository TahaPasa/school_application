import 'package:flutter/material.dart';
import 'package:school_app/repository/mesajlar_repository.dart';
import 'package:school_app/repository/ogrenciler_repository.dart';
import 'package:school_app/repository/ogretmenler_repository.dart';

import 'pages/mesajlar_sayfasi.dart';
import 'pages/ogrenciler_sayfasi.dart';
import 'pages/ogretmenler_sayfasi.dart';

void main() {
  runApp(const OgrenciApp());
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaSayfa(title: 'Öğrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends StatefulWidget{
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  MesajlarRepository mesajlarRepository = MesajlarRepository();
  OgrencilerRepository ogrencilerRepository = OgrencilerRepository();
  OgretmenlerRepository ogretmenlerRepository = OgretmenlerRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(

              decoration: const BoxDecoration(

                color: Colors.blue,

              ),
              child:
              Stack(
                  children: const [
                    Positioned(
                      bottom: 8.0,
                      left: 4.0,
                      child: Text(
                        "Taha Pasha App Making",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),]
              ),

            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,),
              title: const Text('Öğrenciler'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,),
              title: const Text('Öğretmenler'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,),
              title: const Text('Mesajlar'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MesajlarSayfasi(mesajlarRepository),
                ));
                setState(() {

                });
              },
              child: Text("${mesajlarRepository.mesajSayisi} Yeni Mesaj"),
            ),
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OgrencilerSayfasi(ogrencilerRepository),
                ));
              },
              child: Text("${ogretmenlerRepository.Ogretmenler.length} Öğrenci"),
            ),
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OgretmenlerSayfasi(ogretmenlerRepository),
                ));
              },
              child: Text("${ogrencilerRepository.Ogrenciler.length} Öğretmen"),
            ),

          ],
        ),
      ),

    );
  }
}
