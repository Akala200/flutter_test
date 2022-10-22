import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:test_app/models/order_model.dart';


String username = '3442f8959a84dea7ee197c632cb2df15';
String password = '13023';
String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));

class ApiService{


  static String baseUrl = "https://desolate-sea-15998.herokuapp.com/api/aggregate";

  static Future<void> editOrder(OrderModel order) async{
    var sellerId = json.encode(order);
    var orderJson = jsonDecode(sellerId);
    Uri uri = Uri.parse("$baseUrl/order_items/${orderJson["seller_id"]}");
    var response = await http.put(uri, body: { "order_id": orderJson["order_id"], "product_id": orderJson["product_id"] }, headers: <String, String>{'authorization': basicAuth});
  }

  static Future<List<OrderModel>> fetchOrders(String userId) async{
    Uri uri = Uri.parse("$baseUrl/order_items?limit=30");
    var response = await http.get(uri,  headers: <String, String>{'authorization': basicAuth});
    var orderJson = jsonDecode(response.body);
    // log(orderJson["data"]["data"].toString());

    List<OrderModel> ordersList = [];

    for(var order in orderJson["data"]["data"]){
      OrderModel newOrder = OrderModel.fromJson(order);
      ordersList.add(newOrder);
    }

    return ordersList;
  }

  static Future<void> deleteOrder(OrderModel order) async{
    var sellerId = json.encode(order);
    var orderJson = jsonDecode(sellerId);

    Uri uri = Uri.parse("$baseUrl/order_items/${orderJson["seller_id"]}");
    var response = await http.delete(uri, headers: <String, String>{'authorization': basicAuth});
    var noteJson = jsonDecode(response.body);
    log(noteJson.toString());
  }

}