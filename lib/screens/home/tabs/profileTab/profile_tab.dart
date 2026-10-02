import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/home/tabs/profileTab/watchList/watch_list.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/profile_header.dart';
import '../../../widgets/sliver_app_bar_delegate.dart';
import 'history/history.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: ProfileHeader(currentUser: currentUser),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              TabBar(
                dividerColor: AppColors.transparentColor,
                indicatorColor: AppColors.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs:  [
                  Tab(icon: Icon(Icons.menu, color: AppColors.primaryColor)),
                  Tab(icon: Icon(Icons.folder, color: AppColors.primaryColor)),
                ],
              ),
            ),
          ),
        ],
        body:  TabBarView(
          children: [
            WatchList(),
            HistoryList(),
          ],
        ),
      ),
    );
  }
}