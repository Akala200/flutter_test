import 'package:flutter/material.dart';
import 'package:test_app/provider/order_providers.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/order_model.dart';

class AddOrder extends StatefulWidget {

  bool forUpdate;
  OrderModel? order;

  AddOrder({Key? key,required this.forUpdate , this.order}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {

  FocusNode focusNode = FocusNode();
  TextEditingController order_idController = TextEditingController();

  TextEditingController productidController = TextEditingController();

  void addNewOrder(){
    OrderModel newOrder = OrderModel(
        order_id: order_idController.text,
        product_id: productidController.text,
        shipping_limit_date: DateTime.now()
    );
    Provider.of<OrderProviders>(context, listen: false).addOrder(newOrder);
  }

  @override
  void initState() {
    super.initState();
    if(widget.forUpdate){
      productidController.text = widget.order!.product_id!;
      order_idController.text = widget.order!.order_id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              icon: Icon(Icons.done),
              onPressed: (){
                if(widget.forUpdate){
                  widget.order!.order_id = order_idController.text;
                  widget.order!.product_id = productidController.text;
                  widget.order!.shipping_limit_date = DateTime.now();
                  print(widget.order!);
                  Provider.of<OrderProviders>(context,listen: false).updateOrder(widget.order!);
                }else{
                  addNewOrder();
                }
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            TextField(
              controller: order_idController,
              onSubmitted: (val){
                focusNode.requestFocus();
              },
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
              autofocus: (widget.forUpdate) ?false :true,
              decoration: const InputDecoration(
                hintText: 'Seller Id'
              ),
            ),

            TextField(
              controller: productidController ,
              onSubmitted: (val){
                focusNode.requestFocus();
              },
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
              autofocus: (widget.forUpdate) ?false :true,
              decoration: const InputDecoration(
                  hintText: 'Order Id'
              ),
            ),
          ],
        ),
      ),
    );
  }
}