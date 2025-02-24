import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../services/data_service_visitors.dart';
import '../border_container.dart';
import '../../models/visitors.dart';
import '../../utilities/achievements_manager.dart';

class UserAchievementsContainer extends StatelessWidget {
  final DataServiceVisitors dataService = DataServiceVisitors();
  final Visitor visitor;

  UserAchievementsContainer({
    super.key,
    required this.visitor,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/trophy_icon.png',
                height: 25.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Trofeje',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),

        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BorderContainer(
                  padding: 20,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [AchievementManager().getCardContent(index)]),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10.0),

        SmoothPageIndicator(
          controller: _pageController,
          count: 5,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.grey.shade400,
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
