import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/cubit/cart/insert_cart_cubit.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_produk.dart';

const chart = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"; //kode random
String? randomString(int? strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (int i = 0; i < strlen!; i++) {
    result += chart[rnd.nextInt(chart.length)];
  }
  return result;
}

class DetailProduk extends StatefulWidget {
  DataProduct? data;
  DetailProduk(this.data);

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  int counter = 1;
  void minusItem() {
    if (counter == 1) {
      setState(() {
        counter;
      });
    } else {
      setState(() {
        counter--;
      });
    }
  }

  void addItem() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InsertCartCubit>(create: (context) => InsertCartCubit())
      ],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Detail Produk'),
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                ClipRRect(
                  child: Image.network(
                    ImageUrl + '${widget.data?.produkGambar}',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.data?.produkNama}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Item Sub Data',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${widget.data?.produkHarga}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.height / 4,
                              child: Image.network(
                                  ImageUrl + '${widget.data?.produkGambar}'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(50)),
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.height,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          minusItem();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Text(
                        '$counter',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          addItem();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: BlocBuilder<InsertCartCubit, InsertCartState>(
              builder: (context, state) {
                InsertCartCubit cubit = context.read<InsertCartCubit>();
                if (state is InsertCartLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is InsertCartError) {
                  print('${state.message}');
                }
                return MaterialButton(
                  color: Colors.black,
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  textColor: Colors.white,
                  child: Text('Add to Chart'),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    var _orderid = pref.getString('idorder');
                    if (_orderid != null) {
                      await cubit.addItemKeranjang(
                          context,
                          _orderid,
                          widget.data?.produkId.toString(),
                          counter,
                          widget.data?.produkHarga);
                    } else {
                      String? idOrder = randomString(8);
                      pref.setString('idorder', idOrder!);
                      await cubit.addItemKeranjang(
                          context,
                          idOrder,
                          widget.data?.produkId.toString(),
                          counter,
                          widget.data?.produkHarga);
                    }
                  },
                );
              },
            ),
          )),
    );
  }
}
