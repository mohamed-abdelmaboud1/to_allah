class DayInfo {
  final DateTime date;
  bool morningAzkar;
  int prayInMasjid;
  int sunnah;
  bool prayInNabi;
  bool quranVerse;
  bool eveningAzkar;
  bool midnightQiam;
  bool readTabark;

  DayInfo({
    required this.date,
    this.morningAzkar = false,
    this.prayInMasjid = 0,
    this.sunnah = 0,
    this.prayInNabi = false,
    this.quranVerse = false,
    this.eveningAzkar = false,
    this.midnightQiam = false,
    this.readTabark = false,
  });

  factory DayInfo.fromJson(Map<String, dynamic> json) => DayInfo(
        date: DateTime.parse(json["date"]),
        morningAzkar: json["morningAzkar"] ?? false,
        prayInMasjid: json["prayInMasjid"] ?? 0,
        sunnah: json["sunnah"] ?? 0,
        prayInNabi: json["prayInNabi"] ?? false,
        quranVerse: json["quranVerse"] ?? false,
        eveningAzkar: json["eveningAzkar"] ?? false,
        midnightQiam: json["midnightQiam"] ?? false,
        readTabark: json["readTabark"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "morningAzkar": morningAzkar,
        "prayInMasjid": prayInMasjid,
        "sunnah": sunnah,
        "prayInNabi": prayInNabi,
        "quranVerse": quranVerse,
        "eveningAzkar": eveningAzkar,
        "midnightQiam": midnightQiam,
        "readTabark": readTabark,
      };

  void toggleMorningAzkar() => morningAzkar = !morningAzkar;

  void incrementPrayInMasjid() {
    if (prayInMasjid == 5) {
      prayInMasjid = 0;
    } else {
      prayInMasjid++;
    }
  }

  void incrementSunnah() {
    if (sunnah == 12) {
      sunnah = 0;
    } else {
      sunnah += 2;
    }
  }

  void togglePrayInNabi() => prayInNabi = !prayInNabi;

  void toggleQuranVerse() => quranVerse = !quranVerse;

  void toggleEveningAzkar() => eveningAzkar = !eveningAzkar;

  void toggleMidnightQiam() => midnightQiam = !midnightQiam;

  void toggleReadTabark() => readTabark = !readTabark;
}
