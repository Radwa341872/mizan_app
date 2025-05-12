class Installment {
  final int? id;
  final double installment;
  final String time;
  final String notes;

  Installment({
    this.id,
    required this.installment,
    required this.time,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'installment': installment, 'time': time, 'notes': notes};
  }
}
