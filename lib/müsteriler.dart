// ignore: file_names

import 'package:emlak_app/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'model/musteri.dart';

import 'package:emlak_app/sabitler.dart';

import 'musteriGuncelle.dart';

class Musteriler extends StatefulWidget {
  const Musteriler({Key? key}) : super(key: key);

  @override
  State<Musteriler> createState() => _MusterilerState();
}

class _MusterilerState extends State<Musteriler>
    with SingleTickerProviderStateMixin {
  late List<Musteri> _musteriler;
  final DbHelper = DatabaseHelper.instance;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _musteriler = [];
    _query();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _query();
    });
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
              icon: Icon(
            Icons.timelapse_rounded,
            color: Sabitler.iconRengi1,
          )),
          Tab(icon: Icon(Icons.person, color: Sabitler.iconRengi1)),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: sozlesmeliMusteriler()),
          Center(child: sozlesmesizMusteriler()),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  int KalanGun(Musteri musteri, String bicim) {
    int gunfarki = 0;
    int saatfarki = 0;
    if (musteri.sozlesmeBaslangicTarihi != null) {
      int eklenecekAy = musteri.sozlesmeSuresi!;
      DateTime baslangicTarihi =
          DateTime.parse(musteri.sozlesmeBaslangicTarihi!);
      DateTime sozlesmeBitisTarihi = DateTime(baslangicTarihi.year,
          baslangicTarihi.month + eklenecekAy, baslangicTarihi.day);
      DateTime suaninTarihi = DateTime.now();
      Duration fark = sozlesmeBitisTarihi.difference(suaninTarihi);
      gunfarki = fark.inDays;
      saatfarki = fark.inHours;
    }
    if (bicim == "gun") {
      return gunfarki;
    } else {
      return saatfarki;
    }
  }

  void silDialog(Musteri musteri) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sil'),
          content: const Text('Silmek istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                _musteriler.remove(musteri);
                DbHelper.delete(musteri.id!);

                setState(() {});
                // Silme işlemini burada gerçekleştirin
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget sozlesmeliMusteriler() {
    List<Musteri> sozlesmeliMusteriler = [];
    for (var i = 0; i < _musteriler.length; i++) {
      if (_musteriler[i].sozlesmeBaslangicTarihi != null) {
        sozlesmeliMusteriler.add(_musteriler[i]);
      }
    }
    return sozlesmeliMusteriler.isNotEmpty
        ? ListView.builder(
            itemCount: sozlesmeliMusteriler.length,
            itemBuilder: (BuildContext context, int index) {
              Musteri oankiMusteri = sozlesmeliMusteriler[index];
              int kalansaat = KalanGun(oankiMusteri, "saat");
              int kalangun = KalanGun(oankiMusteri, "gun");

              return ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Card(
                  key: ValueKey(oankiMusteri.id),
                  color: Sabitler.anaRenkshade50,
                  shadowColor: Sabitler.anaRenk,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ExpansionTile(
                      childrenPadding: const EdgeInsets.all(14.0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      backgroundColor: Sabitler.anaRenkshade50,
                      tilePadding: const EdgeInsets.all(10.0),
                      // ignore: sort_child_properties_last
                      children: [
                        Text(
                            "Ad/Soyad : ${oankiMusteri.ad} ${oankiMusteri.soyAd}",
                            style: Sabitler.cardTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Telefon : ${oankiMusteri.telefon}",
                                    style: Sabitler.cardTextStyle),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: (() {}),
                                        child: const CircleAvatar(
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.whatsapp,
                                              size: 28,
                                              color: Colors.white,
                                            ))),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: const CircleAvatar(
                                            backgroundColor: Colors.brown,
                                            child: Icon(
                                              Icons.phone,
                                              size: 28,
                                              color: Colors.white,
                                            )))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Text("Durum : Ev Sahibi",
                            style: Sabitler.cardTextStyle),
                        Text("Adres : ${oankiMusteri.adres}",
                            style: Sabitler.cardTextStyle),
                        Text(
                            "Sözleşme Başlangıç : ${DateTime.parse(oankiMusteri.sozlesmeBaslangicTarihi!).day}/${DateTime.parse(oankiMusteri.sozlesmeBaslangicTarihi!).month}/${DateTime.parse(oankiMusteri.sozlesmeBaslangicTarihi!).year} ",
                            style: Sabitler.cardTextStyle),
                        Text(
                            "Sözleşme Süresi : ${oankiMusteri.sozlesmeSuresi} Ay",
                            style: Sabitler.cardTextStyle),
                        if (oankiMusteri.not != "")
                          Text("Not : ${oankiMusteri.not}",
                              style: Sabitler.cardTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  silDialog(oankiMusteri);
                                  setState(() {});
                                },
                                child: const Text(" Sil",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MusteriGuncelle(
                                              guncellenecekMusteri:
                                                  oankiMusteri,
                                              sozlesme: true,
                                            )),
                                  );

                                  setState(() {});
                                },
                                child: const Text(" Güncelle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                          ],
                        )
                      ],
                      title: Text(
                        ("${oankiMusteri.ad} ${oankiMusteri.soyAd}")
                            .toUpperCase(),
                        style: Sabitler.yaziFont2,
                      ),
                      subtitle: subtitle(oankiMusteri),
                      trailing: Icon(Icons.arrow_drop_down_rounded,
                          size: 48, color: Sabitler.iconRengi1),
                      leading: leading(oankiMusteri)),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "Lütfen Müşteri Ekleyiniz..",
              style: TextStyle(color: Sabitler.anaRenk),
            ),
          );
  }

  Widget sozlesmesizMusteriler() {
    List<Musteri> sozlesmesizMusteriler = [];
    for (var i = 0; i < _musteriler.length; i++) {
      if (_musteriler[i].sozlesmeBaslangicTarihi == null) {
        sozlesmesizMusteriler.add(_musteriler[i]);
      }
    }

    return sozlesmesizMusteriler.isNotEmpty
        ? ListView.builder(
            itemCount: sozlesmesizMusteriler.length,
            itemBuilder: (BuildContext context, int index) {
              Musteri oankiMusteri = sozlesmesizMusteriler[index];
              return Card(
                key: ValueKey(oankiMusteri.id),
                shadowColor: Sabitler.anaRenk,
                elevation: 6,
                color: Sabitler.anaRenkshade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ExpansionTile(
                  childrenPadding: const EdgeInsets.all(14.0),

                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  backgroundColor: Sabitler.anaRenkshade50,
                  tilePadding: const EdgeInsets.all(10.0),
                  // ignore: sort_child_properties_last
                  children: [
                    Text(
                        "Ad/Soyad : ${sozlesmesizMusteriler[index].ad} ${sozlesmesizMusteriler[index].soyAd}",
                        style: Sabitler.cardTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Telefon : ${oankiMusteri.telefon}",
                                style: Sabitler.cardTextStyle),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: (() {}),
                                    child: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(
                                          Icons.whatsapp,
                                          size: 28,
                                          color: Colors.white,
                                        ))),
                                const SizedBox(
                                  width: 3,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: const CircleAvatar(
                                        backgroundColor: Colors.brown,
                                        child: Icon(
                                          Icons.phone,
                                          size: 28,
                                          color: Colors.white,
                                        )))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Text("Durum : Ev Arıyor..", style: Sabitler.cardTextStyle),
                    if (oankiMusteri.not != "")
                      Text("Not : ${sozlesmesizMusteriler[index].not}",
                          style: Sabitler.cardTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              silDialog(oankiMusteri);

                              setState(() {});
                            },
                            child: const Text(" Sil",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MusteriGuncelle(
                                          guncellenecekMusteri: oankiMusteri,
                                          sozlesme: false,
                                        )),
                              );

                              setState(() {});
                            },
                            child: const Text(" Güncelle",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                      ],
                    )
                  ],
                  title: Text(
                    ("${oankiMusteri.ad} ${oankiMusteri.soyAd}").toUpperCase(),
                    style: Sabitler.yaziFont2,
                  ),
                  subtitle: const Text("Ev Arıyor.."),
                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      size: 40, color: Sabitler.iconRengi1),
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "Lütfen Müşteri Ekleyiniz..",
              style: TextStyle(color: Sabitler.anaRenk),
            ),
          );
  }

  bool sozlesmeBasladiMi(Musteri musteri) {
    DateTime suan = DateTime.now();
    DateTime baslangicTarihi = DateTime.parse(musteri.sozlesmeBaslangicTarihi!);
    bool basladi;
    Duration fark = baslangicTarihi.difference(suan);
    int gunfarki = fark.inHours;

    if (gunfarki < 0) {
      basladi = true;
    } else {
      basladi = false;
    }

    return basladi;
  }

  Widget subtitle(Musteri musteri) {
    int kalanGun = KalanGun(musteri, "gun");
    int kalansaat = KalanGun(musteri, "saat");

    if (kalansaat < 0) {
      return const Text(
        "Sözleşme Bitti Lütfen Düzenleme Yapınız !",
      );
    } else if (sozlesmeBasladiMi(musteri)) {
      return Text("Sözleşmenin Bitmesine $kalanGun Gün Kaldı");
    } else {
      return const Text("Sözleşme Henüz Başlamadı..");
    }
  }

  Widget leading(Musteri musteri) {
    int kalansaat = KalanGun(musteri, "saat");
    int kalangun = KalanGun(musteri, "gun");
    Color renk = renkAyarla(musteri);

    if (kalansaat < 0) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.warning,
          size: 47,
          color: renk,
        ),
      );
    } else if (sozlesmeBasladiMi(musteri)) {
      return SizedBox(
        child: CircularProgressIndicator(
          value: kalangun / 100,
          strokeWidth: 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(renk),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.access_alarm,
          size: 47,
          color: renk,
        ),
      );
    }
  }

  Color renkAyarla(Musteri musteri) {
    Color renk;
    int kalansaat = KalanGun(musteri, "saat");
    int kalangun = KalanGun(musteri, "gun");

    if (kalansaat < 0) {
      return Colors.red;
    } else if (sozlesmeBasladiMi(musteri)) {
      if (kalangun <= 15) {
        return Colors.orange;
      } else {
        return Colors.indigo;
      }
    } else {
      return Colors.blue;
    }
  }

  _query() async {
    final allRows = await DbHelper.queryAllRows();
    _musteriler.clear();
    allRows.forEach((row) => _musteriler.add(Musteri.fromMap(row)));

    setState(() {});
  }
}
