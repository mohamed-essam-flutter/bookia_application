import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/feature/auth/presentation/page/login.dart';
import 'package:bookia_app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ShowProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: headTitle(fontWeight: FontWeight.w200, fontSize: 24),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(LogoutEvent());
                },
                icon: SvgPicture.asset('assets/icons/Logout (1).svg'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
               if (state is LogoutLoadedState) {
                pushAndRemoveUntil(context: context, screen: home_screen());
                }
            },
            buildWhen: (previous, current) =>
                current is ProfileLoadedState ||
                current is ProfileLoadingState ||
                current is ProfileErrorState,
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                var profileData =
                    context.read<ProfileBloc>().showProfileResponseModel;
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            profileData?.data?.image ?? "",
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const Gap(13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(16),
                              Text(
                                profileData?.data?.name ?? "",
                                style: headTitle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(6),
                              Text(profileData?.data?.email ?? "",
                                  style: headTitle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ColorApp.gray),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(35),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'My Orders',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Edit Profile',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Reset Password',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'FAQ',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Contact Us',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      shadowColor: ColorApp.gray.withOpacity(.3),
                      color: ColorApp.white,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Privacy & Terms',
                          style: headTitle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                );
              } else if(state is ProfileLoadingState){
                return Center(child: Lottie.asset('assets/image/book.json'));
              }else{
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
