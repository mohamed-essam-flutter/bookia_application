import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/feature/home/presentation/page/book_detail/BookDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSellerBooksWidget extends StatelessWidget {
  const BestSellerBooksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is BestSellerLoadedState || current is BestSellerLoadingState,
      builder: (context, state) {
        if (state is BestSellerLoadedState) {
          var book = context.read<HomeBloc>().bestSellerResponseModel?.data;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: book?.products?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 300),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: const BoxDecoration(
                    color: Color(0xffF5EFE1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      push(
                          context: context,
                          screen: book_detail_screen(
                            product: book?.products?[index],
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: book?.products?[index].id ?? "",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                book?.products?[index].image ?? "",
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        //     child: CachedNetworkImage(
                        //       width: double.infinity,
                        //       fit:BoxFit.cover,
                        //   imageUrl: book?.products?[index].image??"",
                        //   errorWidget: (context, url, error) =>const Icon(Icons.error),
                        // )),
                        const Gap(5),
                        Text(
                          book?.products?[index].name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: smallHint(fontSize: 18, color: ColorApp.black),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${book?.products?[index].price}',
                              style: smallHint(color: ColorApp.black),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorApp.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Text(
                                'BUY',
                                style: smallHint(color: ColorApp.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
