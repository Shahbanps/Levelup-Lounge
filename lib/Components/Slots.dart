class Slot {
  String id;
  final int no_of_slots;
  final int no_of_pc;
  final int price;
  final DateTime date;
  final String type;
  final List<String> time;
  Slot({
    this.id = '',
    required this.no_of_slots,
    required this.no_of_pc,
    required this.price,
    required this.date,
    required this.type,
    required this.time,
  });

  Slot.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            no_of_slots: json['no_of_slots']! as int,
            no_of_pc: json['no_of_pc']! as int,
            price: json['price']! as int,
            date: json['date']! as DateTime,
            type: json['type']! as String,
            time: json['time']! as List<String>);

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_of_slots': no_of_slots,
        'no_of_pc': no_of_pc,
        'price': price,
        'date': date,
        'type': type,
        'time': time,
      };
}
