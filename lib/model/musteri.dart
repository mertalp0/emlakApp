import 'package:uuid/uuid.dart';


class Musteri {
  
   
  final String id;
   
  final String ad;
 
  final String soyAd;

  final String telefon;
  
  String? adres;
 
  DateTime? sozlesmeBaslangicTarihi;
 
  int? sozlesmeSuresi;
  
  String? not;

  Musteri(
      {required this.id,
      required this.ad,
      required this.soyAd,
      required this.telefon,
      this.adres,
      this.sozlesmeBaslangicTarihi,
      this.sozlesmeSuresi,
      this.not});

  factory Musteri.create(
      {required String ad, required String soyAd, required String telefon,required String not}) {
    return Musteri(id: const Uuid().v1(), ad: ad, soyAd: soyAd, telefon: telefon,not: not);
  }
  factory Musteri.create2(
      {required String ad,
      required String soyAd,
      required String telefon,
      required String adres,
      required DateTime sozlesmeBaslangicTarihi,
      required int sozlesmeSuresi,
      required String not}) {
    return Musteri(
        id: const Uuid().v1(),
        ad: ad,
        soyAd: soyAd,
        telefon: telefon,
        adres: adres,
        sozlesmeBaslangicTarihi: sozlesmeBaslangicTarihi,
        sozlesmeSuresi: sozlesmeSuresi,
        not: not);
  }
  


Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ad': ad,
      'soyAd': soyAd,
      'telefon': telefon,
      'adres': adres,
      'sozlesmeBaslangicTarihi': sozlesmeBaslangicTarihi?.millisecondsSinceEpoch,
      'sozlesmeSuresi': sozlesmeSuresi,
      'not': not,
    };
  }

}
