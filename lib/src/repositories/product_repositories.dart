
import 'package:simple_bloc/src/data/data_provider.dart';
import 'package:simple_bloc/src/models/product_models.dart';


class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<List<Product>> getProducts() async {
    try {
      final response = await DataProvider.getRequest(
          endpoint: "https://dummyjson.com/products");
      if (response.statusCode == 200) {
        print(getProducts());
        List<Product> products =
            ProductModel.fromRawJson(response.body).products;
        return products;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}