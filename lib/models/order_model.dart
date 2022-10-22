class OrderModel{
  int? order_item_id;
  String? order_id;
  String? product_id;
  String? seller_id;
  DateTime? shipping_limit_date;

  OrderModel({
    this.order_id,
    this.order_item_id,
    this.product_id,
    this.seller_id,
    this.shipping_limit_date
  });

  factory OrderModel.fromJson(Map<String,dynamic> json){
    return OrderModel(
        order_id: json["order_id"],
        order_item_id: json["order_item_id"],
        product_id: json["product_id"],
        seller_id: json["seller_id"],
        shipping_limit_date: DateTime.tryParse(json["shipping_limit_date"])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "order_id": order_id,
      "order_item_id": order_item_id,
      "product_id": product_id,
      "seller_id": seller_id,
      "shipping_limit_date": shipping_limit_date!.toIso8601String(),
    };
  }
}