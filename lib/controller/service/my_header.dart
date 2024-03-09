class MyHeaders {
  static Map<String, String> header() {
    return {
      'Content-Type': 'application/json',

      // 'Authorization': 'Bearer ${AppUser.data?.jwt}'
    };
  }

  static Map<String, String> header2() {
    return {
      'Content-type': 'multipart/form-data;boundary=???',
    };
  }

  static Map<String, String> imageHeader(int docType) {
    return {
      'Content-type': 'application/json',
      // 'userIDnumber': '${AppUser.userId}',
      'docType': '$docType'
    };
  }
}
