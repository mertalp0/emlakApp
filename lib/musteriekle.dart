import 'package:emlak_app/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'model/musteri.dart';
import 'sabitler.dart';

class MusteriEkle extends StatefulWidget {
  const MusteriEkle({super.key});

  @override
  State<MusteriEkle> createState() => _MusteriEkleState();
}

class _MusteriEkleState extends State<MusteriEkle> {
  final DbHelper = DatabaseHelper.instance;
  final formkey = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  String? ad;
  String? soyAd;
  String? telefon;
  String? adres;
  String? sozlesmeBaslangicTarihi;
  int? sozlesmeSuresi;
  String? not;
  late TextEditingController _dateController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
        _dateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Müsteri Ekleme")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ExpansionTile(
                  // ignore: sort_child_properties_last
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                onSaved: (newValue) {
                                  ad = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız....";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.person_add_alt_1,
                                    ),
                                    labelText: "Ad",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  soyAd = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız....";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.person_add_alt_1_outlined,
                                    ),
                                    labelText: "Soyad",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                maxLength: 11,
                                keyboardType: TextInputType.number,
                                onSaved: (newValue) {
                                  telefon = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty || deger.length < 11) {
                                    return "Giris Yapınız....";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                    ),
                                    labelText: "Telefon",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  adres = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız..";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                    ),
                                    labelText: "Adres",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                onTap: () => _selectDate(context),
                                onSaved: (newValue) {
                                  sozlesmeBaslangicTarihi = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız..";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'Tarih seç',
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.calendar_today,
                                    ),
                                    labelText: "Sözleşme Başlangıç Tarihi",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (newValue) {
                                  sozlesmeSuresi =
                                      int.parse(newValue.toString());
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız..";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.post_add_sharp,
                                    ),
                                    labelText: "Sözleşme Süresi(ay)",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                maxLines: null,
                                onSaved: (newValue) {
                                  not = newValue.toString();
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.my_library_books_outlined,
                                    ),
                                    labelText: "Not",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    bool validate =
                                        formkey.currentState!.validate();
                                    if (validate) {
                                      formkey.currentState!.save();

                                      String result = "Kayıt Basarılı";
                                      _insert(
                                          ad,
                                          soyAd,
                                          telefon,
                                          adres,
                                          sozlesmeBaslangicTarihi,
                                          sozlesmeSuresi,
                                          not);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(result)));

                                      setState(() {});
                                    } else {
                                      String result =
                                          "tüm alanları doldurunuz..";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(result)));
                                    }
                                  },
                                  child: const Text("Onayla")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  title: Text(
                    ("SÖZLEŞMELİ MÜŞTERİ EKLE").toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      size: 40, color: Sabitler.anaRenk),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ExpansionTile(
                  // ignore: sort_child_properties_last
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey2,
                          child: Column(
                            children: [
                              TextFormField(
                                onSaved: (newValue) {
                                  ad = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız...";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.person_add_alt_1,
                                    ),
                                    labelText: "Ad",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  soyAd = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty) {
                                    return "Giris Yapınız....";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.person_add_alt_1_outlined,
                                    ),
                                    labelText: "Soyad",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                maxLength: 11,
                                keyboardType: TextInputType.number,
                                onSaved: (newValue) {
                                  telefon = newValue.toString();
                                },
                                autovalidateMode: AutovalidateMode.always,
                                validator: (deger) {
                                  if (deger!.isEmpty || deger.length < 11) {
                                    return "Giris Yapınız...";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                    ),
                                    labelText: "Telefon",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                maxLines: null,
                                onSaved: (newValue) {
                                  not = newValue.toString();
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Sabitler.anaRenkshade50,
                                    prefixIcon: const Icon(
                                      Icons.my_library_books_outlined,
                                    ),
                                    labelText: "Not",
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    bool validate =
                                        formkey2.currentState!.validate();
                                    if (validate) {
                                      formkey2.currentState!.save();
                                      String result = "Kayıt Basarılı";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(result)));
                                      _insert(
                                          ad,
                                          soyAd,
                                          telefon,
                                          adres,
                                          sozlesmeBaslangicTarihi,
                                          sozlesmeSuresi,
                                          not);
                                      setState(() {});
                                    } else {
                                      String result =
                                          "tüm alanları doldurunuz..";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(result)));
                                    }
                                  },
                                  child: const Text("Onayla")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  title: Text(
                    ("SÖZLEŞMESİZ MÜŞTERİ EKLE").toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      size: 40, color: Sabitler.anaRenk),
                ),
              ),
            ],
          ),
        ));
  }

  void _insert(String? ad, String? soyAd, String? telefon, String? adres,
      String? sozlesmeBaslangicTarihi, int? sozlesmeSuresi, String? not) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnad: ad,
      DatabaseHelper.columnsoyAd: soyAd,
      DatabaseHelper.columntelefon: telefon,
      DatabaseHelper.columnadres: adres,
      DatabaseHelper.columnsozlesmeBaslangicTarihi: sozlesmeBaslangicTarihi,
      DatabaseHelper.columnsozlesmeSuresi: sozlesmeSuresi,
      DatabaseHelper.columnnot: not,
    };
    Musteri musteri = Musteri.fromMap(row);
    final id = await DbHelper.insert(musteri);
  }
}
