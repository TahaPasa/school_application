import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/repository/mesajlar_repository.dart';
import 'package:school_app/repository/ogrenciler_repository.dart';
import 'package:school_app/repository/ogretmenler_repository.dart';
import 'package:school_app/utilities/google_sign_in.dart';

import 'pages/mesajlar_sayfasi.dart';
import 'pages/ogrenciler_sayfasi.dart';
import 'pages/ogretmenler_sayfasi.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
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
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool IsFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initalizeFirebase();
  }

  Future<void> initalizeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      IsFirebaseInitialized = true;
    });
    if(FirebaseAuth.instance.currentUser != null)
      {
        anaSayfayaGit();
      }

  }

  void anaSayfayaGit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AnaSayfa(title: 'Öğrenci Ana Sayfa'),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IsFirebaseInitialized? ElevatedButton(
          onPressed: () async {
            await signInWithGoogle();
            anaSayfayaGit();
          },
          child: Text("Google sign-in")):CircularProgressIndicator(),
      ),
    );
  }
}

class AnaSayfa extends ConsumerWidget{
  const AnaSayfa({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository  =  ref.watch(ogrencilerProvider);
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                  children:  [
                    Text(FirebaseAuth.instance.currentUser!.displayName!),
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
              leading: const Icon(Icons.circle,color: Colors.teal,size: 20,),
              title: const Text('Öğrenciler'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,size: 20,),
              title: const Text('Öğretmenler'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,size: 20,),
              title: const Text('Mesajlar'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.circle,color: Colors.teal,size: 20,),
              title: const Text('Çıkış Yap'),
              onTap: () async {
                await SignOutWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SplashScreen(),));
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0,vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MesajlarSayfasi(),
                          )
                        );
                      },
                      child: DecoratedBox(

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.amberAccent,
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(Icons.message,color: Colors.white,size: 40),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                              child: Text("${ref.watch(YeniMesajSayisiProvider)} Yeni Mesaj",style: const TextStyle(color: Colors.indigo)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OgrencilerSayfasi(),
                        ));
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.amberAccent,
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(Icons.person_pin_outlined,color: Colors.white,size: 40),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                              child: Text("${ogrencilerRepository.Ogrenciler.length} Öğrenci",style: const TextStyle(color: Colors.indigo)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OgretmenlerSayfasi(),
                        ));
                      },

                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.amberAccent,
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(Icons.account_circle_outlined,color: Colors.white,size: 40),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                              child: Text("${ogretmenlerRepository.ogretmenler.length} Öğretmen",style: const TextStyle(color: Colors.indigo)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
