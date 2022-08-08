import 'package:flutter/material.dart';
import 'package:tech_proj/services/api_client.dart';
import 'package:tech_proj/widgets/drop_down.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiClient client = ApiClient();
  List<String>? currencies = [];
  String? from = "USD";
  String? to = "USD";
  String amountToConvert = "0";
  String rate = "0";
  double result = 0;

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  void currencyConvert(String value) {
    setState(() {
      amountToConvert = value.isEmpty ? "0" : value;
      double amount = double.parse(amountToConvert);
      double actualRate = double.parse(rate);
      result = amount * actualRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  currencyConvert(value);
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Enter the amount to convert...",
                  labelStyle: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currencies == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "From",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            customDropDown(currencies, from, (val) async {
                              setState(() {
                                from = val;
                              });
                              rate = await client.setRate(from, to);
                              if (!mounted) return;
                              setState(() {});
                              currencyConvert(amountToConvert);
                            }),
                          ],
                        ),
                  currencies == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "TO",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            customDropDown(currencies, to, (val) async {
                              setState(() {
                                to = val;
                              });
                              rate = await client.setRate(from, to);
                              if (!mounted) return;
                              setState(() {});
                              currencyConvert(amountToConvert);
                            }),
                          ],
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Text(
                      "Selected Currency Rate : ",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      rate == "0" ? "Currency Pair not available" : rate,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Converted Amount : ",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      result.toString(),
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
