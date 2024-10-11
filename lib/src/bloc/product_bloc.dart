import 'package:simple_bloc/src/helpers/handleExpection.dart';
import 'package:simple_bloc/src/models/product_models.dart';
import 'package:simple_bloc/src/repositories/product_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {
    on<GetProductEvent>(
        (GetProductEvent event, Emitter<ProductState> emit) async {
      // TODO: implement event handler
      emit(ProductLoadingState());
      try {
        final products = await productRepository.getProducts();
        if (products.isEmpty) {
          emit(ProductEmptyState());
        } else {
          emit(ProductLoadedState(products: products));
        }
      } catch (e) {
        final message = handleExceptionWithMessage(e);
        print(message);
        emit(ProductLoadingFailedState(errorMessage: message));
      }
    });
  }
}
