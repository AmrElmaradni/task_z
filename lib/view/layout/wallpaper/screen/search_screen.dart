import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../../helper/networking/api_helper.dart';
import '../../../../helper/theme/app_colors.dart';
import '../../../../helper/utils/common_methods.dart';
import '../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/custom_button/custom_button.dart';
import '../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../controller/search_wallpaper_controller.dart';
import '../widget/wallpaper_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryEC = TextEditingController();

  @override
  void dispose() {
    _queryEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchWallpaperController()
        ..initial()
        ..getWallpapers(_queryEC.text),
      child: PageContainer(
        child: Consumer<SearchWallpaperController>(
            builder: (context, searchController, _) {
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(
                tr(AppLocaleKey.search),
              ),
              automaticallyImplyLeading: true,
              height: kToolbarHeight + 50,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomFormField(
                    controller: _queryEC,
                    hintText: tr(AppLocaleKey.search),
                    suffixIcon: SizedBox(
                      width: 47,
                      height: 47,
                      child: Center(
                        child: CustomButton(
                          width: 40,
                          height: 40,
                          onPressed: () {
                            searchController.initial();
                            searchController.getWallpapers(_queryEC.text);
                          },
                          child: const Icon(
                            Icons.search_rounded,
                            color: AppColor.buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: NotificationListener(
              onNotification: (ScrollEndNotification t) =>
                  CommonMethods.endScroll(t, () {
                if (searchController.wallpapersHasPagination) {
                  searchController.getWallpapers(_queryEC.text);
                }
              }),
              child: Column(
                children: [
                  Expanded(
                    child: ApiResponseWidget(
                      apiResponse: searchController.wallpapersResponse,
                      isEmpty: searchController.wallpapers.isEmpty,
                      onReload: () =>
                          searchController.getWallpapers(_queryEC.text),
                      child: GridView.count(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                          searchController.wallpapers.length,
                          (index) => WallpaperWidget(
                            wallpaper: searchController.wallpapers[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (searchController.wallpapersResponse.state ==
                      ResponseState.pagination) ...{
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  },
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
