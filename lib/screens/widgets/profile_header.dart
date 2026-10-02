// screens/widgets/profile_header.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/widgets/Main_loading_widget.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routs.dart';
import '../../core/utils/app_text_styels.dart';
import '../../core/utils/mob_size.dart';
import 'custom_elevated_button.dart';

class ProfileHeader extends StatelessWidget {
  final User currentUser;

  const ProfileHeader({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Container(
      color: AppColors.darkGrey,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        spacing: height * 0.015,
        children: [
          SizedBox(height: height * 0.06),

          // USER INFORMATION

          _UserInfoRow(currentUser: currentUser),

          // ACTION BUTTONS

          _ActionButtonsRow(),
        ],
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final User currentUser;

  const _UserInfoRow({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    var width = context.width;

    return Row(
      spacing: width * 0.03,
      children: [
        Expanded(
          child: _UserProfileAvatarAndName(
            currentUser: currentUser,
          ),
        ),

        Expanded(
          child: _FirestoreCountCounter(
            collectionName: 'wish_list',
            label: context.tr("wish_list"),
            userId: currentUser.uid,
          ),
        ),

        Expanded(
          child: _FirestoreCountCounter(
            collectionName: 'watched_movies',
            label: context.tr('history'),
            userId: currentUser.uid,
          ),
        ),
      ],
    );
  }
}

class _UserProfileAvatarAndName extends StatelessWidget {
  final User currentUser;

  const _UserProfileAvatarAndName({
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;

    // Listen to Firestore so the profile updates automatically
    // when name or avatar changes.

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }

        // Default values

        String userName =
            currentUser.displayName ?? 'User';

        String userImage = AppAssets.gamer1;

        // Get updated data from Firestore

        if (snapshot.hasData && snapshot.data!.exists) {
          final data =
              snapshot.data!.data() as Map<String, dynamic>;

          userName = data['name'] ?? userName;

          final String avatar =
              data['avatar'] ?? '';

          // Use Firestore avatar if it exists.
          // Otherwise use the default avatar.

          if (avatar.isNotEmpty) {
            userImage = avatar;
          }
        }

        return Column(
          spacing: height * 0.01,
          children: [
            ClipOval(
              child: Image.asset(
                userImage,
                height: height * 0.10,
                width: height * 0.10,
                fit: BoxFit.cover,

                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Image.asset(
                    AppAssets.gamer1,
                    height: height * 0.10,
                    width: height * 0.10,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            Text(
              userName.isEmpty ? 'User' : userName,
              style: AppTextStyels.white20bold,
            ),
          ],
        );
      },
    );
  }
}

class _FirestoreCountCounter extends StatelessWidget {
  final String collectionName;
  final String label;
  final String userId;

  const _FirestoreCountCounter({
    required this.collectionName,
    required this.label,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;

    return Column(
      spacing: height * 0.01,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection(collectionName)
              .snapshots(),

          builder: (context, snapshot) {
            int count = snapshot.hasData
                ? snapshot.data!.docs.length
                : 0;

            return Text(
              '$count',
              style: AppTextStyels.white36bold,
            );
          },
        ),

        Text(
          label,
          style: AppTextStyels.white24bold,
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = context.width;

    return Row(
      spacing: width * 0.02,
      children: [
        Expanded(
          flex: 2,
          child: CustomElevatedButton(
            text: context.tr("edit_profile"),

            // Open update profile screen

            func: () => Navigator.pushNamed(
              context,
              AppRouts.updateProf,
            ),

            color: AppColors.primaryColor,
            textStyle: AppTextStyels.black20regular,
          ),
        ),

        Expanded(
          flex: 1,
          child: CustomElevatedButton(
            text: context.tr("exit"),

            // Sign out the current user

            func: () async {
              await FirebaseAuth.instance.signOut();

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouts.loginRouteName,
                  (route) => false,
                );
              }
            },

            color: AppColors.redColor,
            textStyle: AppTextStyels.White20regular,
          ),
        ),
      ],
    );
  }
}

