class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final questions = [
  Question(text: "İspanya'da 1982 Dünya Kupası'nı Batı Almanya'yı 3-1 yenerek hangi ülke kazandı?", options: [
    const Option(text: "ABD", isCorrect: false),
    const Option(text: "İspanya", isCorrect: false),
    const Option(text: "İtalya", isCorrect: true),
    const Option(text: "Uruguay", isCorrect: false)
  ]),
  Question(
    text: "Aşağıdakilerden hangisi uluslararası bir organizasyon değildir?",
    options: [
      const Option(text: "FIFA", isCorrect: false),
      const Option(text: "NATO", isCorrect: false),
      const Option(text: "MIT", isCorrect: true),
      const Option(text: "UNICEF", isCorrect: false)
    ],
  ),
  Question(
    text: "Aşağıdakilerden hangisi Portekiz'in başkentidir?",
    options: [
      const Option(text: "Porto", isCorrect: false),
      const Option(text: "Braga", isCorrect: false),
      const Option(text: "Lizbon", isCorrect: true),
      const Option(text: "Aveiro", isCorrect: false)
    ],
  ),
  Question(
    text: "1930'da Albert Einstein ve bir meslektaşına niçin 1781541 numaralı ABD patenti verildi?",
    options: [
      const Option(text: "Buzdolabı", isCorrect: true),
      const Option(text: "Araba", isCorrect: false),
      const Option(text: "Mutfak Dolabı", isCorrect: false),
      const Option(text: "Televizyon", isCorrect: false)
    ],
  ),
  Question(
    text: "Hangi aktör Philadelphia (1993) ve Forrest Gump (1994) filmlerinde en iyi aktör Oscar'ı kazandı?",
    options: [
      const Option(text: "Brad Pitt", isCorrect: false),
      const Option(text: "Morgan Freeman", isCorrect: false),
      const Option(text: "Samuel L. Jackson", isCorrect: false),
      const Option(text: "Tom Hanks", isCorrect: true)
    ],
  ),
  Question(
    text: "Hugh Jackman hangi filmde Christian Bale'in oynadığı karakterin rakip bir sihirbazı olarak rol aldı?",
    options: [
      const Option(text: "Wolverine", isCorrect: false),
      const Option(text: "Esaretin Bedeli", isCorrect: false),
      const Option(text: "The Prestige", isCorrect: true),
      const Option(text: "Batman", isCorrect: false)
    ],
  ),
  Question(
    text: "Gümüşün kimyasal sembolü nedir?",
    options: [
      const Option(text: "Au", isCorrect: false),
      const Option(text: "Na", isCorrect: false),
      const Option(text: "Mg", isCorrect: false),
      const Option(text: "Ag", isCorrect: true)
    ],
  ),
  Question(
    text: "Yetişkin bir insan günde ortalama kaç defa nefes alır?",
    options: [
      const Option(text: "20.000", isCorrect: true),
      const Option(text: "500", isCorrect: false),
      const Option(text: "50.000", isCorrect: false),
      const Option(text: "100.000", isCorrect: false)
    ],
  ),
  Question(
    text: "Türkiye'ye gelmiş en iyi yabancı futbolcu kimdir?",
    options: [
      const Option(text: "Alex De Souza", isCorrect: false),
      const Option(text: "Wesley Sneijder", isCorrect: true),
      const Option(text: "Lugano", isCorrect: false),
      const Option(text: "Yattara", isCorrect: false)
    ],
  ),
  Question(
    text: "Tac Mahal hangi ülkededir?",
    options: [
      const Option(text: "Brezilya", isCorrect: false),
      const Option(text: "Güney Afrika", isCorrect: false),
      const Option(text: "Hindistan", isCorrect: true),
      const Option(text: "İtalya", isCorrect: false)
    ],
  ),
];
