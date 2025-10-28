class AppApis {
  static String baseUrl = 'https://api.ohsc.riayatech.ae';

  static String getToken = "$baseUrl/api/account/GetToken";
  static String getTokenTypes = "$baseUrl/api/APIPharmacyQueue/GetTokenTypes";
  static String generateToken = "$baseUrl/api/APIPharmacyQueue/GenerateToken";
  static String getRoomAllTokens = "$baseUrl/api/APIPharmacyQueue/GetRoomAllTokens";
}
