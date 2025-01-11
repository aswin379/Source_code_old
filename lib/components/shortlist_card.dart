import 'package:flutter/material.dart';

import '../const/my_theme.dart';
import '../const/style.dart';
import '../screens/core.dart';
import '../screens/my_dashboard_pages/interest/express_interest_middleware.dart';
import '../screens/my_dashboard_pages/shortlist/shortlist_action.dart';
import 'common_widget.dart';
import 'my_images.dart';

class ShortlistCard extends StatelessWidget {
  final AppState? state;
  final dynamic index;
  final BuildContext? maincontext;

  const ShortlistCard({Key? key, this.state, this.index, this.maincontext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// box decoration

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()]),
      // child0

      child: Row(
        children: [
          Container(
            height: 139,
            width: 86.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MyImage.imageProvider(
                  state!.shortlistState!.shortlistData![index].photo,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 31,
                width: 86.0,
                decoration: const BoxDecoration(
                  color: MyTheme.app_accent_color,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12.0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          state!.shortlistState!.index = index;
                          if (state!.shortlistState!.shortlistData![index]
                              .expressInterest!) {
                            store.dispatch(ShowMessageAction(
                                msg: "Already Expressed Interest"));
                          } else {
                            if (state!.accountState!.profileData!
                                    .remainingInterest ==
                                0) {
                              store.dispatch(ShowMessageAction(
                                  msg: "Please update your package"));
                            } else {
                              store.dispatch(expressInterestMiddleware(
                                  userId: state!.shortlistState!
                                      .shortlistData![index].userId!));
                            }
                          }
                        },
                        icon: state!.myInterestState!.isLoading! &&
                                state!.shortlistState!.index == index
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : state!.shortlistState!.shortlistData![index]
                                    .expressInterest!
                                ? Image.asset(
                                    'assets/icon/icon_love_full.png',
                                  )
                                : Image.asset(
                                    'assets/icon/icon_love.png',
                                  ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          store.dispatch(RemoveShortlistAction(
                              context: maincontext,
                              data: state!
                                  .shortlistState!.shortlistData![index]));
                        },
                        icon: Image.asset('assets/icon/icon_ignore_cancel.png'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, top: 14.0, right: 10.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state!.shortlistState!.shortlistData![index].name ?? "",
                    style: Styles.bold_arsenic_14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${state!.shortlistState!.shortlistData![index].age} years',
                        style: Styles.regular_arsenic_14,
                      )),
                      Expanded(
                          child: Text(
                        state!.shortlistState!.shortlistData![index].country ??
                            "",
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: Styles.regular_arsenic_14,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${state!.shortlistState!.shortlistData![index].religion}',
                        style: Styles.regular_arsenic_14,
                      )),
                      Expanded(
                          child: Text(
                        state!.shortlistState!.shortlistData![index]
                                .mothereTongue ??
                            "",
                        style: Styles.regular_arsenic_14,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
