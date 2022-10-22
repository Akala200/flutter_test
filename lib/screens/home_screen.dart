import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/provider/order_providers.dart';
import 'package:provider/provider.dart';

import './edit_order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    OrderProviders orderProviders = Provider.of<OrderProviders>(context);

    return Scaffold(
      body: (orderProviders.isLoading) ?Center(child: CircularProgressIndicator())
      : (orderProviders.orderList.length > 0) ?GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: orderProviders.orderList.length,
        itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                //update
                Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => AddOrder(forUpdate: true, order: orderProviders.orderList[index],)));
              },
              onLongPress: (){
                //delete
                orderProviders.deleteNode(orderProviders.orderList[index]);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 800),content: Text('Order Removed')));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                ),
                width: 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderProviders.orderList[index].seller_id! , style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    Text(orderProviders.orderList[index].product_id! , style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,color: Colors.grey[700]),maxLines: 5,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
          );
        },
      ) :Center(child: Text('No Notes Yet, Click on + to start adding')),
    );
  }
}