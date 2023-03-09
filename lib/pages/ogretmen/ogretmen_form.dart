import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/models/ogretmen.dart';
import 'package:school_app/services/data_service.dart';

class OgretmenForm extends ConsumerStatefulWidget {
  const OgretmenForm({Key? key}) : super(key: key);

  @override
  _OgretmenFormState createState() => _OgretmenFormState();
}

class _OgretmenFormState extends ConsumerState<OgretmenForm> {
  final Map<String,dynamic> girilen = {};
  final _formKey = GlobalKey<FormState>();

  bool isSaving= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Öğretmen"),),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Ad"),
                  ),
                  validator: (value) {
                    if(value?.isNotEmpty != true){
                      return "Ad girmeniz gerekli";
                    }
                  },
                  onSaved: (newValue){
                    girilen["ad"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Soyad"),
                  ),
                  validator: (value) {
                    if(value?.isNotEmpty != true){
                      return "Soyad girmeniz gerekli";
                    }
                  },
                  onSaved: (newValue){
                    girilen["soyad"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Yaş"),
                  ),
                  validator: (value) {
                    if(value== null || value.isNotEmpty != true){
                      return "Yaş girmeniz gerekli";
                    }
                    if(int.tryParse(value) == null){
                      return "Rakamlarla Yaş giriniz.";
                    }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue){
                    girilen["yas"] = (newValue);
                  },
                ),
                DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      child: Text("Erkek"),
                      value: "Erkek",
                    ),
                    DropdownMenuItem(
                      child: Text("Kadın"),
                      value: "Kadın",
                    ),
                  ],
                  value: girilen["cinsiyet"],
                  onChanged: (value) {
                    setState(() {
                      girilen["cinsiyet"] = value;
                    });
                  },
                  validator: (value) {
                    if(value == null){
                      return "Lütfen bir cinsiyet seçiniz.";
                    }
                  },
                ),
                isSaving ? Center(child: CircularProgressIndicator()) : ElevatedButton(
                  onPressed: () {
                    final formState = _formKey.currentState;
                    if(formState == null) return;
                    if(formState.validate() == true){
                      formState.save();
                      print(girilen);
                    }
                    _kaydet();

                  }, child: Text("Kaydet"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _kaydet() async {

    bool bitti = false;
    while(!bitti){
      try{
        setState((){
          isSaving = true;
        });
        await gercektenKaydet();
        bitti = true;
        Navigator.of(context).pop(true);
      } catch (e) {
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        await snackBar.closed;
      }
      finally{
        setState((){
          isSaving = false;
        });
      }
    }



  }

  Future<void> gercektenKaydet() async {
    await ref.read(dataServiceProvider).ogretmenEkle(Ogretmen.fromMap(girilen));
  }
}

