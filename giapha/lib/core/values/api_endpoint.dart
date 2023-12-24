class ApiEndpoint {
  static const String local = "http://192.168.35.106:3000/v1/api";
  static const String severDev =
      "https://doan-server-git-dev-giapha-mohamedgonl1s-projects.vercel.app/v1/api";
  static const String serverProd =
      "https://doan-server-jgx3cwill-mohamedgonl1s-projects.vercel.app/v1/api";
  static const String login = "user/login";
  static const String register = "user/signup";
  static const String searchUser = "user/search";
  static const String getAddress = "";
  static const String getAllFamilies = "giapha/get-all";
  static const String createNewFamily = "giapha/create";
  static const String editFamilyInfo = "giapha/edit";
  static const String searchFamilyByText = "giapha/search";
  static const String deleteFamily = "giapha/delete";
  static const String addMember = "member/create";
  static const String searchMember = "member/search";
  static const String getTree = "member/get-all";
  static const String editMember = "member/edit";
  static const String deleteMember = "member/delete";
  static const String uploadImage = "upload/upload-image";
  static const String handleMutipleAction = "member/mutiple-action";
}
