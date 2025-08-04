import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/product/data/datasources/product_local_datasources.dart';
import 'features/product/data/datasources/product_remote_datasources.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_new_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/domain/usecases/view_all_product.dart';
import 'features/product/domain/usecases/view_specific_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
  await _setUpCore();
  await _setUpFeature();
}

Future<void> _setUpCore() async {
  final sharedPreferences = SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> _setUpFeature()async {
  sl.registerLazySingleton<ProductLacalDatasource>(() => ProductLacalDatasourceImpl(sl()));
  sl.registerLazySingleton<ProductRemoteDatasources>(() => ProductRemoteDatasourcesImpl(client: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(productLacalDatasource: sl(), productRemoteDatasource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CreateProductUsecase>(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton<DeleteProductUsecase>(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton<UpdateProductUsecase>(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton<ViewAllProductsUsecase>(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton<ViewProductUsecase>(() => ViewProductUsecase(sl()));

  sl.registerFactory(() => ProductBloc(viewAllProductUsecase: sl(), viewProductUsecase: sl(), createProductUsecase: sl(), updateProductUsecase: sl(), deleteProductUsecase: sl()));
}