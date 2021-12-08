import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/keranjang/keranjang_cubit.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_keranjang.dart';

class DataKeranjang2 extends StatefulWidget {
  const DataKeranjang2({Key? key}) : super(key: key);

  @override
  _DataKeranjang2State createState() => _DataKeranjang2State();
}

class _DataKeranjang2State extends State<DataKeranjang2> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeranjangCubit>(create: (context) => KeranjangCubit())
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Keranjang Belanja'),
        ),
        body: BlocBuilder<KeranjangCubit, KeranjangState>(
          builder: (context, state) {
            KeranjangCubit cubit = context.read<KeranjangCubit>();
            if (state is KeranjangInitial) {
              cubit.getListKeranjang(context);
            }
            if (state is KeranjangLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is KeranjangSuccess) {
              return Container(
                color: Colors.white,
                height: 800,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cubit.resKeranjang?.dataKeranjang?.length,
                    itemBuilder: (context, index) {
                      DataKeranjang? data =
                          cubit.resKeranjang?.dataKeranjang?[index];
                      return Container(
                        height: 80,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 300,
                                width: 100,
                                child: Image.network(
                                  ImageUrl + '${data?.produkGambar}',
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                              ),
                              title: Text(
                                '${data?.produkNama}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text('${data?.detailHarga}'),
                              trailing: Text(
                                '${data?.detailQty}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
            return Scaffold();
          },
        ),
      ),
    );
  }
}
