import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmail() {
    if (trim().isEmpty) {
      return false;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(trim());
  }

  bool isValidPassword() {
    if (trim().isEmpty) {
      return false;
    }
    return RegExp(r'^(?=.*[A-Za-z@$!%*#?&])(?=.*\d).{6,}$').hasMatch(this);
  }

  DateTime toDateTime({String? format}) =>
      DateFormat(format ?? 'dd/MM/yyyy').parse(this);

  String get getFileExtention {
    return split('.').last;
  }

  String getFormatedUrl(String url, Map<String, String> variables) {
    return url.replaceAllMapped(RegExp(r'{{\w+}}'), (match) {
      final key = match.group(0)?.replaceAll(RegExp(r'[{}]'), '');
      return variables[key] ?? url;
    });
  }
}

extension StringNullSafetyExtension on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;
}
