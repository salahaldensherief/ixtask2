import 'package:flutter/material.dart';
import '../data/models/pizza_item_model.dart';
import 'package:task2ix/presentation/widgets/recommended_pizza_widget.dart';

class PizzaCheckoutScreen extends StatefulWidget {
  final PizzaItemModel pizza;
  final List<PizzaItemModel> pizzas;

  const PizzaCheckoutScreen(
      this.pizza, {
        super.key,
        required this.pizzas,
      });

  @override
  State<PizzaCheckoutScreen> createState() => _PizzaCheckoutScreenState();
}

class _PizzaCheckoutScreenState extends State<PizzaCheckoutScreen> {
  bool isExpanded = false;
  List<PizzaItemModel> selectedOptions = [];
  String couponCode = '';
  double discount = 0.0;

  @override
  Widget build(BuildContext context) {
    widget.pizza.selectOptions = selectedOptions;

    double totalPrice = widget.pizza.calcItemPrice - discount;
    if (totalPrice < 0) totalPrice = 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text("Checkout"),
            )
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => isExpanded = !isExpanded);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  constraints: BoxConstraints(
                    minHeight: 150,
                    maxHeight: isExpanded ? 370 : 150,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pizza.icon ?? '',
                            style: const TextStyle(fontSize: 80),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pizza.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.pizza.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${widget.pizza.getBasePrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      if (isExpanded) ...[
                        const SizedBox(height: 10),
                        const Text(
                          "Add-ons:",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.pizza.options.length,
                            itemBuilder: (context, index) {
                              final option = widget.pizza.options[index];
                              final isSelected =
                              selectedOptions.contains(option);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedOptions.remove(option);
                                    } else {
                                      selectedOptions.add(option);
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.green.shade100
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(option.icon!, style: const TextStyle(fontSize: 40)),
                                      const SizedBox(height: 5),
                                      Text(option.name),
                                      const SizedBox(height: 5),
                                      Text(
                                        "\$${option.basePrice.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              RecommendedPizzaWidget(
                pizzas: widget.pizzas,
                onAdd: (pizza) {
                  setState(() {
                    if (!selectedOptions.contains(pizza)) {
                      selectedOptions.add(pizza);
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Coupon Code",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    couponCode = value.trim();
                    discount = widget.pizza.getCouponDiscount(
                        couponCode, widget.pizza.calcItemPrice);
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
