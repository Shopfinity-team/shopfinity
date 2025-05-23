class Profile{
  final String username;
  final String email;
  final String phone;
  final String address;
  final String profilePicture;
  final String cardType;
  final String cardNumber;
  final String cardExpiry;

  Profile({
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.profilePicture,
    required this.cardType,
    required this.cardNumber,
    required this.cardExpiry,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      profilePicture: json['profilePicture'],
      cardType: json['cardType'],
      cardNumber: json['cardNumber'],
      cardExpiry: json['cardExpiry'],
    );
  }
}