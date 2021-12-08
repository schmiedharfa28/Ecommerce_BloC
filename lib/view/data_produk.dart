import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/produk/produk_cubit.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/view/detail_produk.dart';

class DataProduk extends StatefulWidget {
  const DataProduk({Key? key}) : super(key: key);

  @override
  _DataProdukState createState() => _DataProdukState();
}

class _DataProdukState extends State<DataProduk> {
  ProdukCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProdukCubit>(create: (context) => ProdukCubit())
      ],
      child: BlocBuilder<ProdukCubit, ProdukState>(builder: (context, state) {
        cubit = context.read<ProdukCubit>();
        if (state is ProdukInitial) {
          cubit?.getDataProduk();
        }
        if (state is ProdukLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProdukSuccess) {
          return GridView.builder(
            itemCount: cubit?.resGetProduk?.dataProduct?.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              DataProduct? data = cubit?.resGetProduk?.dataProduct?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailProduk(data)));
                },
                child: GridTile(
                    footer: Container(
                      height: 50,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${data?.produkNama}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '${data?.produkHarga}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        ImageUrl + '${data?.produkGambar}',
                        fit: BoxFit.cover,
                      ),
                    )),
              );
            },
          );
        }
        return Container();
      }),
    );
  }
}
