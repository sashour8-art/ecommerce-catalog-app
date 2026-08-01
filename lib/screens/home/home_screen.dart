import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// تم تصحيح مسارات الاستيراد لتتوافق مع اسم الحزمة الصحيح
import 'package:ecommerce_catalog_app/cubits/store/store_cubit.dart';
import 'package:ecommerce_catalog_app/cubits/store/store_state.dart';
import 'package:ecommerce_catalog_app/widgets/category_card.dart';
import 'package:ecommerce_catalog_app/widgets/state_widgets.dart';
import 'package:ecommerce_catalog_app/screens/products/products_screen.dart';
import 'package:ecommerce_catalog_app/screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit()..fetchCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is CategoriesLoading || state is StoreInitial) {
              return const LoadingWidget();
            }

            if (state is CategoriesError) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () => context.read<StoreCubit>().fetchCategories(),
              );
            }

            if (state is CategoriesLoaded) {
              final categories = state.categories;

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<StoreCubit>().fetchCategories();
                },
                child: categories.isEmpty
                    ? Stack(
                  children: [
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                    const Center(
                      child: Text(
                        'No categories found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                )
                    : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductsScreen(
                              categorySlug: category.slug,
                              categoryName: category.name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}