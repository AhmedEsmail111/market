import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding/onboarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboarding/onboarding_item.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/helper_functions.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var isLast = false;
  final pageController = PageController();
  final List<BoardingModel> boardingList = [
    BoardingModel(
      image: onBoarding,
      title: 'Shop App',
      body:
          'Where you find everything you want in just one place with just one press',
    ),
    BoardingModel(
      image: onBoarding2,
      title: 'Convenient',
      body:
          'Save Time, Money, and struggle by using Shop App. We\'re committed to make your life easier.',
    ),
    BoardingModel(
      image: onBoarding3,
      title: 'Unlimited Sales',
      body:
          'No matter what you\'re doing want to buy, you will find the right deal with the right price for you with our unlimited Sale ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.saveData(key: isBoarding, value: true);
              HelperFunctions.pussAndRemoveAll(
                context,
                const LoginScreen(),
              );
            },
            child: const Text('SKIP'),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boardingList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                      print(isLast);
                    } else {
                      setState(() {
                        isLast = false;
                      });
                      print(isLast);
                    }
                  },
                  controller: pageController,
                  itemCount: boardingList.length,
                  itemBuilder: (context, index) => BuildOnBoardingItem(
                    model: boardingList[index],
                  ),
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                    controller: pageController,
                    count: boardingList.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CacheHelper.saveData(key: isBoarding, value: true);
                        HelperFunctions.pussAndRemoveAll(
                          context,
                          const LoginScreen(),
                        );
                      } else {
                        print('$isLast scroll');
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
