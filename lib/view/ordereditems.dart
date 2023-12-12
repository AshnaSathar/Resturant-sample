class OrderedItem {
  final String productName;
  final double price;
  final int quantity;

  OrderedItem({
    required this.productName,
    required this.price,
    required this.quantity,
  });
}

class Order {
  final List<OrderedItem> orderedItems;

  Order({required this.orderedItems});

  double get totalAmount {
    return orderedItems.fold(
        0.0, (total, item) => total + item.price * item.quantity);
  }
}
