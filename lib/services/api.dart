import 'dart:io';

import 'package:Sarwaya/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List> loginCustomer(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/customers/login.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> createCustomer(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/customers/register.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        print(serverResponse["response"]);
        return serverResponse["response"];
      }
      if ((response.statusCode == 400)) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getAllAgencies() async {
    try {
      final response = await http.get(
        '${Urls.BASE_API_URL}/agencies/read.php',
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getAgencyLocations(String agency) async {
    try {
      final response = await http.get(
        '${Urls.BASE_API_URL}/agencies/locations.php?agencyID=' + agency,
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getScheduleOfCars(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/agencies/schedules.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> addNewBooking(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/bookings/new.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        print(serverResponse["response"]);
        return serverResponse["response"];
      }
      if ((response.statusCode == 400)) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> addAnonymousBooking(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/bookings/anonymous.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        print(serverResponse["response"]);
        return serverResponse["response"];
      }
      if ((response.statusCode == 400)) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getCustomerBookings(String customer) async {
    try {
      final response = await http.get(
        '${Urls.BASE_API_URL}/bookings/user.php?customerID=' + customer,
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return newData["data"];
      }
      if ((response.statusCode == 404)) {
        return newData["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getCustomerDetails(String customer) async {
    try {
      final response = await http.get(
        '${Urls.BASE_API_URL}/customers/accounts/user.php?customerID=' +
            customer,
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(newData["data"]);
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateCustomer(
      Map<String, dynamic> data, String customer) async {
    try {
      final response = await http.put(
        '${Urls.BASE_API_URL}/customers/accounts/update.php?customerID=' +
            customer,
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String> changePassword(
      Map<String, dynamic> data, String customer) async {
    try {
      final response = await http.put(
        '${Urls.BASE_API_URL}/customers/accounts/change_password.php?customerID=' +
            customer,
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        print(serverResponse["response"]);
        return serverResponse["response"];
      }
      if ((response.statusCode == 400)) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> buyTicket(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        '${Urls.BASE_API_URL}/bookings/buy.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        print(serverResponse["response"]);
        return serverResponse["response"];
      }
      if ((response.statusCode == 400)) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> recoverPasword(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        '${Urls.BASE_API_URL}/customers/accounts/recover.php',
        body: json.encode(data),
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final serverResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return serverResponse["response"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List> getAgencyTimeTable(String agencyID) async {
    try {
      final response = await http.get(
        '${Urls.BASE_API_URL}/agencies/timetable.php?agencyID=' + agencyID,
        headers: {HttpHeaders.authorizationHeader: Urls.TOKEN},
      );
      final newData = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(newData["data"]);
        return newData["data"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
