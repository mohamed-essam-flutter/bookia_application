import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(ShowCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Cart', style: headTitle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is RemoveFromCartLoadedState) {
                  context.read<HomeBloc>().add(ShowCartEvent());
                  Navigator.pop(context);
                } else if (state is RemoveFromCartLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current is ShowCartLoadedState ||
                  current is ShowCartLoadingState,
              builder: (context, state) {
                if (state is ShowCartLoadedState) {
                  var cart =
                      context.read<HomeBloc>().showCartResponseModel?.data;
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: cart?.cartItems?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  cart?.cartItems?[index].itemProductImage ??
                                      "",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          cart?.cartItems?[index]
                                                  .itemProductName ??
                                              "",
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
                                                  RemoveFromCartEvent(cart
                                                          ?.cartItems?[index]
                                                          .itemId ??
                                                      0));
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                            )),
                                      ],
                                    ),
                                    Text(
                                      '\$ ${cart?.cartItems?[index].itemProductPrice ?? ""}',
                                      style: headTitle(fontSize: 18),
                                    ),
                                    const Gap(4),
                                    Row(
                                      children: [
                                        FloatingActionButton.small(
                                          onPressed: () {},
                                          child: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                        Text(
                                          '\$ ${cart?.cartItems?[index].itemTotal ?? ""}',
                                          style: headTitle(fontSize: 18),
                                        ),
                                        FloatingActionButton.small(
                                          onPressed: () {},
                                          child: const Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Lottie.asset('assets/image/book.json'),
                  );
                }
              },
            ),
            const Gap(20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Text(
                    'Total :',
                    style: headTitle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$ 95 ',
                  style: headTitle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(19),
            custom_widget_button(onPressed: () {}, text: 'Checkout'),
            const Gap(10)
          ],
        ),
      ),
    );
  }
}
