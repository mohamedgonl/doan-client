class DataAlert {
  String message;
  String title;
  ToastType type;
  Map<String, dynamic>? payload;

  DataAlert(this.message, this.title, this.type, {this.payload});
}

// Type of alert
enum ToastType { success, error, warning }
