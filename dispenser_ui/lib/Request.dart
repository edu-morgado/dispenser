import 'dart:async';
import 'package:http/http.dart' as http;





class Requests {

  static final String serverURL = "htpp://localhost:5000";
  static http.Client client;
  
  // Use when multiple requests necessary
  static void openClient() {
    if (client == null) client = http.Client();
  }

  static void closeClient() {
    if (client != null) client.close();
    client = null;
  }

  static Function get _get {
    if (client == null) return http.get;
    return client.get;
  }

  static Function get _post {
    if (client == null) return http.post;
    return client.post;
  }

  static Function get _put {
    if (client == null) return http.put;
    return client.put;
  }

}