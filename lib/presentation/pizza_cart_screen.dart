import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/presentation/cubits/cart_cubit.dart';
import '../data/models/pizza_item_model.dart';
import 'package:task2ix/presentation/widgets/recommended_pizza_widget.dart';

class PizzaCartScreen extends StatefulWidget {
  final List<PizzaItemModel> items;

  const PizzaCartScreen({super.key, required this.items,  });
  @override
  State<PizzaCartScreen> createState() => _PizzaCartScreenState();
}
class _PizzaCartScreenState extends State<PizzaCartScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.items.fold(0, (sum, e) => sum + e.calcItemPrice);
    final PizzaItemModel item;

    return Scaffold(
      appBar: AppBar(title:  Text('Cart')),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total: ${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
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
          padding:  EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
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
                                    item.addRemoveOption(option: option);
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  margin:  EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        item.selectOptions.contains(option)
                                            ? Colors.green.withOpacity(0.3)
                                            : Colors.black12,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        option.icon ?? '',
                                        style:  TextStyle(fontSize: 30),
                                      ),
                                       SizedBox(height: 5),
                                      Text(option.name),
                                       SizedBox(height: 5),
                                      Text(
                                        "\$${option.basePrice.toStringAsFixed(2)}",
                                        style:  TextStyle(fontSize: 14),
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
              RecommendedPizzaWidget(onAdd: (pizza) {},),
               SizedBox(height: 20),
              TextField(
                decoration:  InputDecoration(
                  labelText: "Coupon Code",
                  border: OutlineInputBorder(),
                ),

                  onChanged: (value) {
                    double discount = 0;
                    for (var item in widget.items) {
                      discount += item.getCouponDiscount(value, item.basePrice);
                    }
                    setState(() {
                      totalPrice -= discount;
                    });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
