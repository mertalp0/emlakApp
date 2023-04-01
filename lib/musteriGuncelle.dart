

import 'package:flutter/material.dart';
import 'model/musteri.dart';

// ignore: must_be_immutable
class MusteriGuncelle extends StatefulWidget {
  Musteri guncellenecekMusteri;
  bool sozlesme ; 

  MusteriGuncelle({required this.guncellenecekMusteri,required this.sozlesme, super.key});

  @override
  State<MusteriGuncelle> createState() => _MusteriGuncelleState();
}

class _MusteriGuncelleState extends State<MusteriGuncelle> {

  final _formKey = GlobalKey<FormState>();
  late String _ad;
  late String _soyAd;
  late String _telefon;
  late String _adres;
  late String _sozlesmeBaslangicTarihi;
  late String _sozlesmeSuresi;
  late String _not;

  TextEditingController? _adController;
  TextEditingController? _telefonController;
  TextEditingController? _soyAdController;
  TextEditingController? _adresController;
  TextEditingController? _sozlemeBaslangicTarihiController;
  TextEditingController? _sozlesmeSuresiController;
  TextEditingController? _notController;

  bool _isEditing = false;
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
   
    _adController = TextEditingController(text: widget.guncellenecekMusteri.ad);
    _telefonController =
        TextEditingController(text: widget.guncellenecekMusteri.telefon);

    _soyAdController =
        TextEditingController(text: widget.guncellenecekMusteri.soyAd);
    _adresController = TextEditingController(
        text: widget.guncellenecekMusteri.adres.toString());

    _sozlemeBaslangicTarihiController = TextEditingController(
        text: widget.guncellenecekMusteri.sozlesmeBaslangicTarihi.toString());

    _sozlesmeSuresiController = TextEditingController(
        text: widget.guncellenecekMusteri.sozlesmeSuresi.toString());
    _notController =
        TextEditingController(text: widget.guncellenecekMusteri.not);

    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _adController!.dispose();
    _telefonController!.dispose();
    _soyAdController!.dispose();
    _adresController!.dispose();
    _sozlemeBaslangicTarihiController!.dispose();
    _sozlesmeSuresiController!.dispose();
    _notController!.dispose();

    super.dispose();
  }

  void _onEditPressed() {
    setState(() {
      _isEditing = true;
    });
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
        _ad = _adController!.text;
        _telefon = _telefonController!.text;
        _soyAd = _soyAdController!.text;
        _adres = _adresController!.text;
        _sozlesmeBaslangicTarihi = _sozlemeBaslangicTarihiController!.text;
        _sozlesmeSuresi = _sozlemeBaslangicTarihiController!.text;
      });
      String result = "Güncelleme Başarılı";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      try {
       if(widget.sozlesme){
         Musteri a = Musteri.create2(
            ad: _ad,
            soyAd: _soyAd,
            telefon: _telefon,
            adres: _adres,
            sozlesmeBaslangicTarihi: DateTime.parse(_sozlesmeBaslangicTarihi),
            sozlesmeSuresi: int.parse(_sozlesmeSuresi),
            not: _not);
        debugPrint(a.ad);
       }
       else{
        Musteri a = Musteri.create(
            ad: _ad,
            soyAd: _soyAd,
            telefon: _telefon,        
            not: _not);
        debugPrint(a.ad);

       }
      } catch (e) {
        debugPrint('Hata oluştu: $e');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _sozlemeBaslangicTarihiController!.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişi Bilgileri'),
        actions: <Widget>[
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _onEditPressed,
            ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _onSavePressed,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    enabled: _isEditing,
                    controller: _adController,
                    decoration: const InputDecoration(labelText: 'Ad'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ad boş olamaz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    enabled: _isEditing,
                    controller: _soyAdController,
                    decoration: const InputDecoration(labelText: 'Soyad'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Soyad boş olamaz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLength: 11,
                    enabled: _isEditing,
                    controller: _telefonController,
                    decoration: const InputDecoration(labelText: 'Telefon'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 11) {
                        return 'Telefon numarası boş olamaz';
                      }
                      return null;
                    },
                  ),
                  if (_sozlesmeSuresiController!.text != "null")
                    TextFormField(
                      enabled: _isEditing,
                      controller: _adresController,
                      decoration: const InputDecoration(labelText: 'Adres'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Adres boş olamaz';
                        }
                        return null;
                      },
                    ),
                  if (_sozlesmeSuresiController!.text != "null")
                    TextFormField(
                      enabled: _isEditing,
                      onTap: () => _selectDate(context),
                      onSaved: (newValue) {},
                      autovalidateMode: AutovalidateMode.always,
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          return "Giris Yapınız..";
                        } else {
                          return null;
                        }
                      },
                      controller: _sozlemeBaslangicTarihiController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Tarih seç',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                        labelText: "Sözleşme Başlangıç Tarihi",
                      ),
                    ),
                  if (_sozlesmeSuresiController!.text != "null")
                    TextFormField(
                      keyboardType: TextInputType.number,
                      enabled: _isEditing,
                      controller: _sozlesmeSuresiController,
                      decoration: const InputDecoration(labelText: 'Kontrat Süresi'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kontrat Süresi boş olamaz';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    enabled: _isEditing,
                    controller: _notController,
                    decoration: const InputDecoration(labelText: 'Not'),
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
