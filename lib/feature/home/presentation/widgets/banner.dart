import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int selectedBanner = 0;
  @override
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeBannerEvent());
  }

  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeBannerLoadedState,
      builder: (context, state) {
        if (state is HomeBannerLoadedState) {
          var banner = context.read<HomeBloc>().homeBannerResponseModel?.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: banner?.sliders?.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // child: Image.network(
                              //   banner?.sliders?[itemIndex].image??"",
                              //   width: double.infinity,
                              //   height: 50,
                              //   scale: 0.5,
                              //   fit: BoxFit.cover,
                              // )
                              child: CachedNetworkImage(
                                imageUrl:
                                    banner?.sliders?[itemIndex].image ?? "",
                                height: 150,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                              top: 1,
                              left: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Find out the best books to read',
                                    style: smallHint(color: ColorApp.white),
                                  ),
                                  Text(
                                    'when you don’t even know what',
                                    style: smallHint(color: ColorApp.white),
                                  ),
                                  Text(
                                    'to read!!!',
                                    style: smallHint(color: ColorApp.white),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () {},
                                      child: Text(
                                        'Explore',
                                        style:
                                            smallHint(color: ColorApp.primary),
                                      ))
                                ],
                              ))
                        ],
                      ),
                  options: CarouselOptions(
                    height: 150,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    onPageChanged: (value, reason) {
                      setState(() {
                        selectedBanner = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              const Gap(14),
              Center(
                child: SmoothPageIndicator(
                    controller: PageController(initialPage: selectedBanner),
                    count: banner?.sliders?.length ?? 0,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 7,
                        expansionFactor: 7,
                        radius: 7,
                        activeDotColor: ColorApp.primary),
                    onDotClicked: (index) {}),
              ),
              const Gap(30),
              Column(
                children: [
                  Text(
                    'Popular Books',
                    style: headTitle(),
                  ),
                ],
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
