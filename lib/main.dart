import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/kategori/kategori_cubit.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/data_global/preference_data.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_kategori.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/view/auth/login.dart';
import 'package:training_magang/view/auth/profile_user.dart';
import 'package:training_magang/view/auth/register.dart';
import 'package:training_magang/view/data_keranjang.dart';
import 'package:training_magang/view/data_meal.dart';
import 'package:training_magang/view/data_produk.dart';
import 'package:training_magang/view/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KategoriCubit>(create: (context) => KategoriCubit())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Udacoding Store'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () async {
                await SavePreference().clearAll().then((value) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                          (route) => false)
                    });
              },
              icon: Icon(Icons.lock),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DataKeranjang2()));
              },
              icon: Icon(Icons.shopping_basket),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text('${dataGlobal.user?.userNama}'),
                accountEmail: Text('${dataGlobal.user?.userEmail}'),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileUser()));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: 55,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 65,
                    ),
                  ),
                ),
              ),
              ListTile(title: Text('List Chart'), onTap: () {}),
              ListTile(title: Text('List History'), onTap: () {}),
            ],
          ),
        ),
        body: BlocBuilder<KategoriCubit, KategoriState>(
          builder: (context, state) {
            KategoriCubit cubit = context.read<KategoriCubit>();
            if (state is KategoriInitial) {
              cubit.getDataKategori();
            }
            if (state is KategoriCubit) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is KategoriSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                        items: cubit.resGetKategori?.data?.map((e) {
                          return Image.network(
                            ImageUrl + '${e.foto}',
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.resGetKategori?.data?.length,
                          itemBuilder: (context, index) {
                            DataKategori? data =
                                cubit.resGetKategori?.data?[index];
                            return Container(
                              margin: EdgeInsets.all(2),
                              height: 110,
                              width: 110,
                              child: Column(
                                children: [
                                  Image.network(
                                    ImageUrl + '${data?.foto}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('${data?.kategoriNama}')
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(height: 560, child: DataProduk()),
                    // Container(
                    //   height: 200,
                    //   child: DataMeal(),
                    // )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
