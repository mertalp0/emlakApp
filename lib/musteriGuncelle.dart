import 'package:flutter/material.dart';
import 'databaseHelper.dart';
import 'model/musteri.dart';

// ignore: must_be_immutable
class MusteriGuncelle extends StatefulWidget {
  Musteri guncellenecekMusteri;
  bool sozlesme;

  MusteriGuncelle(
      {required this.guncellenecekMusteri, required this.sozlesme, super.key});

  @override
  State<MusteriGuncelle> createState() => _MusteriGuncelleState();
}

class _MusteriGuncelleState extends State<MusteriGuncelle> {
  final DbHelper = DatabaseHelper.instance;
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
    setState(() {
      _isEditing = false;
    });
    int id = widget.guncellenecekMusteri.id!;
    String ad = _adController!.text;
    String soyAd = _soyAdController!.text;
    String telefon = _telefonController!.text;
    String adres = _adresController!.text;
    String sozlesmeBaslangicTarihi = _sozlemeBaslangicTarihiController!.text;
    String sozlesmeSuresi = _sozlesmeSuresiController!.text;
    String not = _notController!.text;

    _update(id, ad, soyAd, telefon, adres, sozlesmeBaslangicTarihi,
        sozlesmeSuresi, not);
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
                  if (widget.sozlesme)
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
                  if (widget.sozlesme)
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
                  if (widget.sozlesme)
                    TextFormField(
                      keyboardType: TextInputType.number,
                      enabled: _isEditing,
                      controller: _sozlesmeSuresiController,
                      decoration:
                          const InputDecoration(labelText: 'Kontrat Süresi'),
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

  void _update(int id, String ad, String soyAd, String telefon, String adres,
      String sozlesmeBaslangicTarihi, String sozlesmeSuresi, String not) async {
    Musteri musteri;
    if (sozlesmeSuresi == 'null') {
      musteri = Musteri(id, ad, soyAd, telefon, null, null, null, not);
    } else {
      musteri = Musteri(id, ad, soyAd, telefon, adres, sozlesmeBaslangicTarihi,
          int.parse(sozlesmeSuresi), not);
    }
    final rowsAffected = await DbHelper.update(musteri);
  }
}
