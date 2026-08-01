import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/store/store_cubit.dart';
import '../../../../cubits/store/store_state.dart';
import '../../../../widgets/product_card.dart';
import '../../../../widgets/state_widgets.dart';
import 'product_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String categorySlug;
  final String categoryName;

  const ProductsScreen({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit()..fetchProductsByCategory(categorySlug),
      child: Scaffold(
        appBar: AppBar(title: Text(categoryName)),
        body: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is ProductsLoading || state is StoreInitial) {
              return const LoadingWidget();
            }

            if (state is ProductsError) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () => context
                    .read<StoreCubit>()
                    .fetchProductsByCategory(categorySlug),
              );
            }

            if (state is ProductsLoaded) {
              final products = state.products;
              if (products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}