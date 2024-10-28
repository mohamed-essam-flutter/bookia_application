import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/feature/home/presentation/page/wishlist/bookmark.dart';
import 'package:bookia_app/feature/home/presentation/page/cart/cart.dart';
import 'package:bookia_app/feature/home/presentation/page/home/home.dart';
import 'package:bookia_app/feature/profile/presentation/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigationbar_view extends StatefulWidget {
  const Navigationbar_view({super.key});

  @override
  State<Navigationbar_view> createState() => _Navigationbar_viewState();
}

class _Navigationbar_viewState extends State<Navigationbar_view> {
  int selectedIconTheme = 0;
  List<Widget> page = [
    const HomeView(),
    const BookmarkView(),
    const CartView(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[selectedIconTheme],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: ColorApp.primary,
          unselectedItemColor: ColorApp.border,
          backgroundColor: ColorApp.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: selectedIconTheme,
          onTap: (value) {
            setState(() {
              selectedIconTheme = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/Home.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/Home.svg',
                  colorFilter:
                      const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/Bookmark.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/Bookmark.svg',
                  colorFilter:
                      const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                ),
                label: 'Bookmark'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/cart.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  colorFilter:
                      const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/Profile.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/Profile.svg',
                  colorFilter:
                      const ColorFilter.mode(ColorApp.primary, BlendMode.srcIn),
                ),
                label: 'Profile'),
          ]),
    );
  }
}
