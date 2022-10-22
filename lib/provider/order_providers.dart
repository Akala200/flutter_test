import 'package:flutter/cupertino.dart';
import '../models/order_model.dart';
import '../services/api_service.dart';

class OrderProviders with ChangeNotifier{

  List<OrderModel> orderList = [];
  
  bool isLoading = true;

  OrderProviders(){
    fetchingOrder();
  }

  void sortOrder(){
    orderList.sort((a, b) => b.shipping_limit_date!.compareTo(a.shipping_limit_date!));
  }

  //Create
  void addOrder(OrderModel order){
    orderList.add(order);
    sortOrder();
    notifyListeners();
    ApiService.editOrder(order);
  }

  // Read
  void fetchingOrder() async{
    orderList = await ApiService.fetchOrders('kalash27k@gmail.com');
    isLoading = false;
    sortOrder();
    notifyListeners();
  }

  // Update
  void updateOrder(OrderModel order){
    int orderIndex = orderList.indexOf(orderList.firstWhere((element) => element.seller_id == order.seller_id));
    orderList[orderIndex] = order;
    sortOrder();
    notifyListeners();
    ApiService.editOrder(order);
  }

  // Delete
  void deleteNode(OrderModel order){
    int orderIndex = orderList.indexOf(orderList.firstWhere((element) => element.seller_id == order.seller_id));
    orderList.removeAt(orderIndex);
    sortOrder();
    notifyListeners();
    ApiService.deleteOrder(order);
  }
}