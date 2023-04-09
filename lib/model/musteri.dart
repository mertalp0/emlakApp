class Musteri {
  int? id;
  String? ad;
  String? soyAd;
  String? telefon;
  String? adres;
  String? sozlesmeBaslangicTarihi;
  int? sozlesmeSuresi;
  String? not;
  Musteri(this.id, this.ad, this.soyAd, this.telefon, this.adres,
      this.sozlesmeBaslangicTarihi, this.sozlesmeSuresi, this.not);

  Musteri.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ad = map['ad'];
    soyAd = map['soyAd'];
    telefon = map['telefon'];
    adres = map['adres'];
    sozlesmeBaslangicTarihi = map['sozlesmeBaslangicTarihi'];
    sozlesmeSuresi = map['sozlesmeSuresi'];
    not = map['not'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ad': ad,
      'soyAd': soyAd,
      'telefon': telefon,
      'adres': adres,
      'sozlesmeBaslangicTarihi': sozlesmeBaslangicTarihi,
      'sozlesmeSuresi': sozlesmeSuresi,
      'not': not,
    };
  }
}
