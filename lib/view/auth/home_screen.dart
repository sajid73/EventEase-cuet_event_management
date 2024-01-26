import 'package:flutter/material.dart';

import '../../widgets/card_01.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildMegaphoneSection(context),
              const SizedBox(height: 29),
              _buildUpcomingEventsSection(context),
              const SizedBox(height: 9),
              _buildViewHierarchySection(context),
              const SizedBox(height: 27),
              _buildRecommendationsSection(context),
              const SizedBox(height: 10),
              _buildConferenceCardSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMegaphoneSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 19),
      decoration: BoxDecoration(
        color: Colors.blue, // Placeholder color
        borderRadius: BorderRadius.circular(33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32), // Placeholder icon
          const SizedBox(height: 27),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.construction, size: 30), // Placeholder icon
              const SizedBox(width: 10),
              const Text("Search..."),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Filters"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUpcomingEventsSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Upcoming Events"),
          Text("See All"),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewHierarchySection(BuildContext context) {
    return SizedBox(
      height: 255,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 19),
        scrollDirection: Axis.horizontal,
        itemCount:
            2, // Change the number of CardOneScreen widgets you want to show
        itemBuilder: (context, index) {
          return const CardOneScreen();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRecommendationsSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Recommendations for you"),
          Text("See All"),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildConferenceCardSection(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.yellow, // Placeholder color
          margin: const EdgeInsets.symmetric(vertical: 16),
        );
      },
    );
  }
}
