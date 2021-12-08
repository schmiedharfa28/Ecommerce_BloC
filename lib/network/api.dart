import 'package:dio/dio.dart';

Dio dio = Dio();
const String baseUrl =
    "http://192.168.10.13:8080/server_commerce/index.php/api";
const String ImageUrl =
    "http://192.168.10.13:8080/server_commerce/image_growback/";
const String apiKategori = "$baseUrl/getKategori";
const String apiProduk = "$baseUrl/getProduk";
const String apiRegister = "$baseUrl/registerCustomer";
const String apiLogin = "$baseUrl/loginCustomer";
const String apiKeranjang = "$baseUrl/addItemKeranjang";
const String apiListKeranjang = "$baseUrl/getKeranjang";
const String apiProfile = "$baseUrl/getProfile";
const String apiUpdateProfile = "$baseUrl/updateDataUser";

//training sendiri

const String apiMealdb =
    "http://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
