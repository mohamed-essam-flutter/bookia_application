import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(ShowWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('wishlist', style: headTitle(fontSize: 24)),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RemoveFromWishlistLoadedState) {
            context.read<HomeBloc>().add(ShowWishlistEvent());
            Navigator.pop(context);
          } else if (state is RemoveFromWishlistLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is AddToCartLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('data loading'),
              backgroundColor: ColorApp.primary,
            ));
          }
        },
        buildWhen: (previous, current) =>
            current is ShowWishlistLoadedState ||
            current is ShowWishlistLoadingState,
        builder: (context, state) {
          if (state is ShowWishlistLoadedState) {
            var wishlist =
                context.read<HomeBloc>().showWishlistResponseModel?.data;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: wishlist?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          wishlist?.data?[index].image ?? "",
                          fit: BoxFit.cover,
                          height: 120,
                          width: 100,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                  wishlist?.data?[index].name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: headTitle(fontSize: 18),
                                )),
                                IconButton.outlined(
                                    padding: const EdgeInsets.all(0),
                                    constraints: const BoxConstraints(
                                        maxHeight: 35, maxWidth: 30),
                                    onPressed: () {
                                      context.read<HomeBloc>().add(
                                          RemoveFromWishlist(
                                              wishlist?.data?[index].id ?? 0));
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                    )),
                              ],
                            ),
                            Text(
                              '\$ ${wishlist?.data?[index].price ?? ""}',
                              style: headTitle(fontSize: 18),
                            ),
                            Center(
                                child: custom_widget_button(
                              onPressed: () {
                                context.read<HomeBloc>().add(AddToCartEvent(
                                    wishlist?.data?[index].id ?? 0));
                              },
                              text: 'Add TO Cart',
                              width: 200,
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Lottie.asset('assets/image/book.json'),
            );
          }
        },
      ),
    );
  }
}
