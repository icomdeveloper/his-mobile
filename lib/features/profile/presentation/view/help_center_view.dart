/*
import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/help_center_container.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, title: 'Help Center'),
        body: SafeArea(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: 4,
            itemBuilder: (context, index) => const HelpCenterContainer(),
          ),
        ));
  }
}
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/profile/data/model/help_center_model.dart';

import '../cubits/help_center/help_center_cubit.dart';
import '../cubits/help_center/help_center_state.dart';

class PolicyListView extends StatelessWidget {
  const PolicyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => PolicyCubit(
        apiServices: ApiServices(dio: Dio()),
      )..fetchPolicies(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Private Policy",
            style: Styles.semiBoldPoppins20,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.grey,
              size: 18,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              color: Colors.grey[300],
              height: 1,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
          ),
        ),
        body: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            if (state is PolicyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PolicyError) {
              return Center(child: Text("❌ Error: ${state.message}"));
            } else if (state is PolicyLoaded) {
              final groupedByCategory = <String, List<Policy>>{};

              for (var policy in state.policies) {
                final category = policy.category.title;
                groupedByCategory.putIfAbsent(category, () => []).add(policy);
              }

              return ListView(
                padding: EdgeInsets.all(screenWidth * 0.04),
                children: groupedByCategory.entries.map((entry) {
                  return CategoryExpansionTile(
                    categoryTitle: entry.key,
                    items: entry.value,
                  );
                }).toList(),
              );
            }
            return const Center(child: Text("No data"));
          },
        ),
      ),
    );
  }
}

class CategoryExpansionTile extends StatelessWidget {
  final String categoryTitle;
  final List<Policy> items;

  const CategoryExpansionTile({
    super.key,
    required this.categoryTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.03),
      child: Container(
        color: Colors.white,
        child: ExpansionTile(
          title: Text(categoryTitle, style: Styles.semiBoldPoppins16),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          children: items.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenWidth * 0.015,
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(item.title,
                      style: Styles.semiBoldPoppins14
                          .copyWith(fontWeight: FontWeight.w500)),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.darkGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: Text(
                        item.body,
                        style: Styles.regularPoppins12,
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
