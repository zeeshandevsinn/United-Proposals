import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:united_proposals_app/controller/service/my_header.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';

class ApiRequest {
  Future post({
    String? url,
    bool isHeader2 = false,
    dynamic body,
    Function(String)? onSuccess,
    Function(String)? onError,
    Function(String)? onError400,
  }) async {
    try {
      // bool isConnected = await checkInternet();
      // if (!isConnected) {
      //   ZBotToast.showToastError(message: 'No Internet Connection');
      //   return false;
      // }
      // debugPrint("$url");
      debugPrint(
          "this is header: ${isHeader2 ? MyHeaders.header2() : MyHeaders.header()}");
      debugPrint("this is body: $body");
      var response = await http
          .post(Uri.parse(url!),
              headers: isHeader2 ? MyHeaders.header2() : MyHeaders.header(),
              body: body)
          .timeout(const Duration(seconds: 90), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint("status code ${response.statusCode}");
      debugPrint("response ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint("i ma here");

        // var res = jsonDecode(response.body);
        // onSuccess!(res['message']);
        // onSuccess!(response.body);
        try {
          // var res = jsonDecode(response.body);
          onSuccess!(response.body);
        } catch (e) {
          // If parsing as JSON fails, treat response.body as a plain string
          onSuccess!(response.body);
        }
      } else if (response.statusCode == 400) {
        var res = jsonDecode(response.body);
        onError400!(res['error']);
      } else if (response.statusCode == 401) {
        onError!(response.body);
      } else if (response.statusCode == 403) {
        onError!(response.body);
      } else if (response.statusCode == 404) {
        onError!(response.body);
      } else if (response.statusCode == 406) {
        onError!(response.body);
      } else {
        onError!(response.body);
      }
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint("i am error");
      debugPrint(e.toString());
      onError!(e.toString());
    }
  }

  Future imageUploader(
      {required int docType,
      required String image,
      String? url,
      var header,
      Function(String)? onSuccess,
      Function(String)? onError,
      Function(String)? onError400}) async {
    try {
      debugPrint(image.toString());
      debugPrint(url.toString());
      Uri uri = Uri.parse(url!);
      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        uri,
      );
      request.headers.addAll(MyHeaders.imageHeader(docType));

      request.files
          .add(await http.MultipartFile.fromPath("myFile", image.toString()));
      // bool isConnected = await checkInternet();
      // if (isConnected) {
      http.StreamedResponse response = await request
          .send()
          .timeout(const Duration(minutes: 1), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.statusCode.toString());

      final responseBody = await response.stream.bytesToString();
      debugPrint(responseBody);

      if (response.statusCode == 200) {
        onSuccess!(responseBody);
      }
      if (response.statusCode == 400) {
        onError400!(responseBody);
      } else {
        onError!(responseBody);
      }
      // }
    } catch (e) {
      debugPrint(e.toString());
      onError!(e.toString());
    }
  }

  // Put Function
  Future put(
      {String? url,
      var body,
      var header,
      Function(String)? onSuccess,
      Function(String)? onError,
      Function(String)? onError400}) async {
    try {
      // print("this is put url: $url");
      //debugPrint("put request body: $body");
      // debugPrint("this is header: ${MyHeaders.header()}");
      var response = await http
          .put(Uri.parse(url!), headers: MyHeaders.header(), body: body)
          .timeout(const Duration(seconds: 90), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.body);
      debugPrint(header);
      debugPrint(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess!(response.body);
      } else if (response.statusCode == 400) {
        onError400!(response.body);
      } else if (response.statusCode == 404) {
        onError!(response.body);
      } else if (response.statusCode == 401) {
        onError!(response.body);
      } else if (response.statusCode == 403) {
        onError!(response.body);
      } else {
        debugPrint(response.body.toString());
        onError!(response.body);
      }
    } catch (e) {
      debugPrint("i am in error catch ${e.toString()}");
      onError!(e.toString());
    }
  }

  // Get function
  Future get(
      {String? url,
      Function(String)? onSuccess,
      Function(String)? onError,
      Function(String)? onError400,
      var header}) async {
    try {
      // debugPrint("this is header: ${jsonEncode(MyHeaders.header())}");
      var response = await http
          .get(Uri.parse(url!), headers: MyHeaders.header())
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        onSuccess!(response.body);
      } else if (response.statusCode == 204) {
        onError!(response.body);
      } else if (response.statusCode == 400) {
        onError400!(response.body);
      } else if (response.statusCode == 404) {
        onError!(response.body);
      } else {
        debugPrint("i am in error  ${response.body}");
        onError!(response.body);
      }
    } catch (e) {
      debugPrint("i am in error catch ${e.toString()}");
      onError!(e.toString());
    }
  }

  // Get function for map
  Future getMap({
    String? url,
    Function(String)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      debugPrint("$url");

      var response = await http
          .get(
        Uri.parse(url!),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        onSuccess!(response.body);
      } else if (response.statusCode == 204) {
        onError!(response.body);
      } else if (response.statusCode == 404) {
        onError!(response.body);
      } else {
        debugPrint("i am in error  ${response.body}");
        onError!(response.body);
      }
    } catch (e) {
      debugPrint("i am in error catch ${e.toString()}");
      onError!(e.toString());
    }
  }
}
