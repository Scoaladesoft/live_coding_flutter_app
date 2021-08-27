class Shipping {
  late String firstName;
  late String lastName;
  late String address1;
  late String address2;
  late String city;
  late String state;
  late String postcode;
  late String country;

  Shipping(
      {required this.firstName,
      required this.lastName,
      required this.address1,
      this.address2 = '',
      required this.city,
      this.state = '',
      this.postcode = '',
      required this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'shipping_first_name': firstName,
      'shipping_last_name': lastName,
      'shipping_address1': address1,
      // 'shipping_address2': address2,
      // 'shipping_city': city,
      // 'shipping_state': state,
      // 'shipping_postcode': postcode,
      // 'shipping_country': country
    };
  }
}
