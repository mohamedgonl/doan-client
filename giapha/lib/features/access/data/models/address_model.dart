class Address {
  final AddressModel commune;
  final AddressModel district;
  final AddressModel province;
  final AddressModel displayAddress;

  Address(
      {required this.commune,
      required this.district,
      required this.province,
      required this.displayAddress});
}

class AddressModel {
  final String id;
  final String displayText;

  AddressModel(this.id, this.displayText);
}
