String baseUrl = "http://192.168.19.182:8000";

Uri registerUrl = Uri.parse("$baseUrl/api/accounts/registration/");
Uri userurl = Uri.parse("$baseUrl/api/accounts/user/");
Uri loginUrl = Uri.parse("$baseUrl/api/accounts/login/");
Uri ownerPropertyUrl = Uri.parse("$baseUrl/api/properties/");

Uri updatePropertyUrl(String id) {
  return Uri.parse("$baseUrl/api/properties/$id/modify/");
}
