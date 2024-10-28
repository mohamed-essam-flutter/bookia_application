import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/feature/home/presentation/widgets/banner.dart';
import 'package:bookia_app/feature/home/presentation/widgets/best_seller_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(BestSellerEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/image/bookia.svg',
          height: 30,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(19),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeBanner(),
              Gap(15),
              BestSellerBooksWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
