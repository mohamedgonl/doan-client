
class Gender {
  final String value;
  final String text;

  const Gender._(this.value, this.text);

  static const Gender male = Gender._("male", "Male");
  static const Gender female = Gender._("female", "Female");
}
