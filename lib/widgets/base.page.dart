import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/views/shared/go_to_cart.view.dart';
import 'package:fuodz/widgets/cart_page_action.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';

class BasePage extends StatefulWidget {
  final bool showAppBar;
  final bool showLeadingAction;
  final bool extendBodyBehindAppBar;
  final Function onBackPressed;
  final bool showCart;
  final bool showtoggle;
  final String title;
  final List<Widget> actions;
  final Widget leading;
  final Widget body;
  final Widget bottomSheet;
  final Widget bottomNavigationBar;
  final Widget fab;
  final bool isLoading;
  final Color appBarColor;
  final double elevation;
  final Color appBarItemColor;
  final Color backgroundColor;
  final bool showCartView;

  BasePage({
    this.showAppBar = false,
    this.leading,
    this.showLeadingAction = false,
    this.onBackPressed,
    this.showCart = false,
    this.showtoggle = false,
    this.title = "",
    this.actions,
    this.body,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.fab,
    this.isLoading = false,
    this.appBarColor,
    this.appBarItemColor,
    this.backgroundColor,
    this.elevation,
    this.extendBodyBehindAppBar,
    this.showCartView = false,
    Key key,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  //
  double bottomPaddingSize = 0;

  //
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Directionality(
      textDirection: translator.activeLocale.languageCode == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.backgroundColor ??
            AppColor.faintBgColor ??
            Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
        appBar: widget.showAppBar
            ? AppBar(
                backgroundColor: widget.appBarColor ?? context.primaryColor,
                elevation: widget.elevation,
                automaticallyImplyLeading: widget.showLeadingAction,
                leading: widget.showLeadingAction
                    ? widget.leading == null
                        ? IconButton(
                            icon: Icon(
                              FlutterIcons.arrow_left_fea,
                              color: widget.appBarItemColor == null
                                  ? Colors.white
                                  : widget.appBarItemColor != Colors.transparent
                                      ? widget.appBarItemColor
                                      : AppColor.primaryColor,
                            ),
                            onPressed: widget.onBackPressed != null
                                ? widget.onBackPressed
                                : () => Get.back(),
                          )
                        : widget.leading
                    : null,
                title: widget.title.text
                    .maxLines(1)
                    .overflow(TextOverflow.ellipsis)
                    .color(widget.appBarItemColor ?? Colors.white)
                    .make(),
                actions: widget.actions ??
                    [
                      widget.showCart
                          ? PageCartAction()
                          : UiSpacer.emptySpace(),
                      widget.showtoggle ?
                      Switch(
                        activeThumbImage: AssetImage('assets/images/toggle_off.png'),
                          inactiveThumbImage: AssetImage('assets/images/toggle_on.png'),
                          // activeThumbImage: new NetworkImage(
                          //   'https://lists.gnu.org/archive/html/emacs-devel/2015-10/pngR9b4lzUy39.png',
                          // ),
                          // inactiveThumbImage: new NetworkImage(
                          //   'http://wolfrosch.com/_img/works/goodies/icon/vim@2x',
                          // ),
                          value: isDarkMode,
                          onChanged: (onChanged) {
                            if (isDarkMode) {
                              Get.changeThemeMode(ThemeMode.light);
                            } else {
                              Get.changeThemeMode(ThemeMode.dark);
                            }
                          }):UiSpacer.emptySpace(),
                    ],
              )
            : null,
        body: Stack(
          children: [
            //body
            VStack(
              [
                //
                widget.isLoading
                    ? LinearProgressIndicator()
                    : UiSpacer.emptySpace(),

                //
                widget.body.pOnly(bottom: bottomPaddingSize).expand(),
              ],
            ),

            //cart view
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: widget.showCartView,
                child: MeasureSize(
                  onChange: (size) {
                    setState(() {
                      bottomPaddingSize = size.height;
                    });
                  },
                  child: GoToCartView(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        floatingActionButton: widget.fab,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
