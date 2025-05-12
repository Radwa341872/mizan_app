class LoginModel {
  final String name;
  final String email;
  final double income;
  final double balance;
  final String country;

  LoginModel({
    required this.name,
    required this.email,
    required this.income,
    required this.balance,
    required this.country,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'income': income,
      'balance': balance,
      'country': country,
    };
  }
}
