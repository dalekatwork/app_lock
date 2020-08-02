class Entry {
  Entry({
    this.label,
    this.timer,
  });

  Entry.fromMap(Map<String, dynamic> map)
      : label = map['label'] as String,
        timer = map['timer'] as String;

  String label;
  String timer;

  // ignore: always_specify_types
  Map<String, dynamic> toMap() => {
        'label': label,
        'timer': timer,
      };
}
