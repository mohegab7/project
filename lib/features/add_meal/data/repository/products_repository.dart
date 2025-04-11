import 'package:active_fit/features/add_meal/data/data_sources/fdc_data_source.dart';
import 'package:active_fit/features/add_meal/data/data_sources/off_data_source.dart';
import 'package:active_fit/features/add_meal/domain/entity/meal_entity.dart';

class ProductsRepository {
  final OFFDataSource _offDataSource;
  final FDCDataSource _fdcDataSource;

  ProductsRepository(this._offDataSource, this._fdcDataSource);

  Future<List<MealEntity>> getOFFProductsByString(String searchString) async {
    try {
      final offWordResponse =
          await _offDataSource.fetchSearchWordResults(searchString);

      final products = offWordResponse.products
          .map((offProduct) => MealEntity.fromOFFProduct(offProduct))
          .toList();

      return products;
    } catch (e) {
      print("Error fetching OFF products: $e");
      throw Exception("Error fetching OFF products: $e");
    }
  }

  Future<List<MealEntity>> getFDCFoodsByString(String searchString) async {
    try {
      final fdcWordResponse =
          await _fdcDataSource.fetchSearchWordResults(searchString);
      final products = fdcWordResponse.foods
          .map((food) => MealEntity.fromFDCFood(food))
          .toList();
      print("FDC products fetched: ${products.length} items"); // Debugging
      return products;
    } catch (e) {
      print("Error fetching FDC foods: $e");
      throw Exception("Error fetching FDC foods: $e");
    }
  }

  Future<MealEntity> getOFFProductByBarcode(String barcode) async {
    try {
      final productResponse = await _offDataSource.fetchBarcodeResults(barcode);

      return MealEntity.fromOFFProduct(productResponse.product);
    } catch (e) {
      print("Error fetching OFF product by barcode: $e");
      throw Exception("Error fetching OFF product by barcode: $e");
    }
  }
}
