import 'package:flutter/material.dart';
import 'package:task2ix/data/models/cart_model.dart';
import 'package:task2ix/presentation/widgets/payment_summary_widget.dart';
import '../data/models/coupon_model.dart';
import '../data/models/pizza_item_model.dart';
import 'package:task2ix/presentation/widgets/recommended_pizza_widget.dart';

class PizzaCartScreen extends StatefulWidget {
  final List<PizzaItemModel> items;
  final PizzaItemModel item;

 const  PizzaCartScreen({
    super.key,
    required this.items,
    required this.item,
  });

  @override
  State<PizzaCartScreen> createState() => _PizzaCartScreenState();
}

class _PizzaCartScreenState extends State<PizzaCartScreen> {
  late CartModel cart;

  @override
  void initState() {
    super.initState();
    cart = CartModel(items: widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Cart')),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total: ${cart.totalPrice.toStringAsFixed(2)}',
              style:  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
             Spacer(),
            ElevatedButton(onPressed: () {}, child:  Text("Checkout")),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.icon ?? '',
                              style:  TextStyle(fontSize: 80),
                            ),
                             SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style:  TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                   SizedBox(height: 8),
                                  Text(
                                    item.description,
                                    style:  TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                   SizedBox(height: 8),
                                  Text(
                                    "\$${item.getBasePrice.toStringAsFixed(2)}",
                                    style:  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon:  Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      cart.removeItem(item.cartItemId);
                                      if (cart.items.isEmpty) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                ),
                                Container(
                                  width: 90,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(item.increaseQty),
                                        child:  Icon(Icons.add, size: 18),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(item.decreaseQty),
                                        child:
                                         Icon(Icons.remove, size: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                         SizedBox(height: 20),
                         Text(
                          "Add-ons:",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: item.options.length,
                            itemBuilder: (context, index) {
                              final option = item.options[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item.toggleOption(option);
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: item.selectOptions.contains(option)
                                        ? Colors.green.withOpacity(0.3)
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        option.icon ?? '',
                                        style:
                                         TextStyle(fontSize: 30),
                                      ),
                                       SizedBox(height: 5),
                                      Text(option.name),
                                       SizedBox(height: 5),
                                      Text(
                                        "\$${option.basePrice.toStringAsFixed(2)}",
                                        style:
                                         TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

               SizedBox(height: 20),

              RecommendedPizzaWidget(
                onAdd: (pizza) {
                  setState(() {
                    cart.addItem(pizza);
                  });
                },
              ),

               SizedBox(height: 20),

              TextField(
                decoration:  InputDecoration(
                  labelText: "Coupon Code",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    cart.applyCoupon(value);
                  });
                },
              ),

               SizedBox(height: 20),

               Text(
                'Payment summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
               SizedBox(height: 20),

              PaymentSummaryWidget(
                value: '\$ ${cart.subTotalPrice.toStringAsFixed(2)}',
                label: 'Subtotal',
              ),
               SizedBox(height: 20),
              PaymentSummaryWidget(
                value: '\$${cart.deliveryFee.toStringAsFixed(2)}',
                label: 'Delivery fee',
              ),
               SizedBox(height: 20),
              PaymentSummaryWidget(
                value: '\$${cart.taxAmount.toStringAsFixed(2)}',
                label: 'Tax Amount',
              ),
               SizedBox(height: 1),

              if (cart.appliedCoupon.type != CouponType.none)
                Text(
                  cart.appliedCoupon.type == CouponType.fixed
                      ? 'Fixed discount applied: ${cart.appliedCoupon.value}'
                      : 'Discount applied: ${cart.appliedCoupon.value}%',
                  style:  TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
