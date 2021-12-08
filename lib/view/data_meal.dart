// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:training_magang/cubit/meal/meal_cubit.dart';
// import 'package:training_magang/cubit/produk/produk_cubit.dart';
// import 'package:training_magang/res/res_get_meal.dart';

// class DataMeal extends StatefulWidget {
//   const DataMeal({Key? key}) : super(key: key);

//   @override
//   _DataMealState createState() => _DataMealState();
// }

// class _DataMealState extends State<DataMeal> {
//   MealCubit? cubit;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [BlocProvider<MealCubit>(create: (context) => MealCubit())],
//         child: BlocBuilder<MealCubit, MealState>(builder: (context, state) {
//           cubit = context.read<MealCubit>();
//           if (state is MealInitial) {
//             cubit?.getDataMeal();
//           }
//           if (state is ProdukLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is MealSuccess) {
//             return GridView.builder(
//                 itemCount: cubit?.resGetMeal?.meals?.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//                 itemBuilder: (context, index) {
//                   Meal? meal = cubit?.resGetMeal?.meals?[index];
//                   return GridTile(
//                       footer: Container(
//                         height: 50,
//                         color: Colors.white.withOpacity(0.5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('${meal?.strMeal}'),
//                           ],
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(8),
//                         //belum selesai
//                       ));
//                 });
//           }
//           return Container();
//         }));
//   }
// }
