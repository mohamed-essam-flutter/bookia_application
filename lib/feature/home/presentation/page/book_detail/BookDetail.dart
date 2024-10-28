import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/feature/home/data/models/response/best_seller_response_model/product.dart';
import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class book_detail_screen extends StatelessWidget {
  final Product? product;
  const book_detail_screen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            InkWell(
              onTap: () {
                context.read<HomeBloc>().add(AddToWishlist(product?.id ?? 0));
              },
              child: SvgPicture.asset('assets/icons/Bookmark.svg'),
            ),
            const Gap(5)
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is AddToWishlistLoadingState ||
                state is AddToCartLoadingState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Lottie.asset('assets/image/book.json');
                  });
            } else if (state is AddToWishlistLoadedState ||
                state is AddToCartLoadedState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('data loading'),
                backgroundColor: ColorApp.primary,
              ));
            } else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('data filer'),
                backgroundColor: ColorApp.red,
              ));
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: product?.id ?? "",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product?.image ?? "",
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    product?.category ?? "",
                    style: smallHint(),
                  ),
                  Text(
                    product?.description ?? "",
                    style: smallHint(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                '\$${product?.price}',
                style: smallHint(color: ColorApp.black, fontSize: 20),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<HomeBloc>()
                      .add(AddToCartEvent(product?.id ?? 0));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Add to cart',
                  style: smallHint(color: ColorApp.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
