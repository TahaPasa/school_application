import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_app/repository/mesajlar_repository.dart';

class MesajlarSayfasi extends StatefulWidget {
  final MesajlarRepository mesajlarRepository;
  const MesajlarSayfasi(this.mesajlarRepository, {Key? key}) : super(key: key);

  @override
  State<MesajlarSayfasi> createState() => _MesajlarSayfasiState();
}

class _MesajlarSayfasiState extends State<MesajlarSayfasi> {

  @override
  void initState() {
    widget.mesajlarRepository.mesajSayisi =0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Mesajlar")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: widget.mesajlarRepository.mesajlar.length,
                itemBuilder: (context, index) {
                  return MesajGorunumu(widget.mesajlarRepository.mesajlar[widget.mesajlarRepository.mesajlar.length - index -1]);
                },
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(),

              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(25)
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                        onPressed: () {
                          print("gönder");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.send,size: 30,),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

class MesajGorunumu extends StatelessWidget {
  final Mesaj mesajlar;
  const MesajGorunumu(this.mesajlar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mesajlar.gonderen == "Taha Alp" ? Alignment.centerRight: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey,
                  width: 2
              ),
              color: Colors.orange.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(8)),

          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(mesajlar.yazi),
          ),
        ),
      ),
    );
  }
}
