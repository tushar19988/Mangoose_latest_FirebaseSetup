import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/onboarding.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color = isDarkMode ? Colors.black : Colors.white;
    return BasePage(
      body: ViewModelBuilder<OnboardingViewModel>.nonReactive(
        viewModelBuilder: () => OnboardingViewModel(context, finishLoading),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: color,
            body: SafeArea(
              child: VStack(
                [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Instacart',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: vm.isBusy,
                    child: BusyIndicator().centered().expand(),
                  ),
                  Visibility(
                    visible: !vm.isBusy,
                    child: OverBoard(
                      pages: vm.onBoardData,
                      showBullets: true,
                      skipText: "Skip",
                      nextText: "Next",
                      finishText: "Done",
                      skipCallback: vm.onDonePressed,
                      finishCallback: vm.onDonePressed,
                      buttonColor: AppColor.primaryColor,
                      inactiveBulletColor: Colors.grey,
                      activeBulletColor: AppColor.primaryColorDark,
                    ).expand(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  finishLoading() {
    setState(() {});
  }
}
