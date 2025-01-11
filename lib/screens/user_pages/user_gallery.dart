import 'package:active_matrimonial_flutter_app/screens/user_pages/public_profile_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../components/common_widget.dart';
import '../../components/my_images.dart';
import '../../const/my_theme.dart';
import '../../const/style.dart';
import '../../helpers/main_helpers.dart';
import '../core.dart';
import '../profile_and_gallery_picure_rqst/gallery_picture_view_request_send.dart';

class UserGallery extends StatelessWidget {
  final AppState state;
  final bool? isAuthUser;
  final int userId;

  const UserGallery(
      {required this.state, required this.isAuthUser, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 10, top: 10.0),
      child: state.publicProfileState!.photogallery == null ||
              state.publicProfileState!.photogallery!.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.common_no_data,
                style: const TextStyle(height: 10),
              ),
            )
          : Stack(
              children: [
                MasonryGridView.count(
                  padding: EdgeInsets.zero,
                  itemCount: state.publicProfileState!.photogallery?.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => store.dispatch(ImageFullViewAction(
                          contextPayload: context, indexPayload: index)),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        child: MyImages.normalImage(state.publicProfileState!
                            .photogallery![index].imagePath),
                      ),
                    );
                  },
                ),
                settingIsActive("gallery_image_privacy", "only_me")
                    ? Container(
                        child: state.memberInfoState?.memberInfo
                                        ?.galleryViewRequestStatus ==
                                    null ||
                                state.memberInfoState!.memberInfo!
                                    .galleryViewRequestStatus! ||
                                state.publicProfileState!.photogallery!.isEmpty
                            ? Container()
                            : Positioned.fill(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icon/icon_lock.png',
                                      color: MyTheme.arsenic,
                                      height: 25,
                                      width: 25,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (!isAuthUser!) {
                                          state
                                                          .accountState!
                                                          .profileData!
                                                          .currentPackageInfo!
                                                          .packageExpiry ==
                                                      "Expired" ||
                                                  state
                                                          .accountState!
                                                          .profileData!
                                                          .remainingGalleryImageView ==
                                                      0
                                              ? store
                                                  .dispatch(ShowMessageAction(
                                                  msg:
                                                      "Please Upgrade your Package",
                                                ))
                                              : showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Gallery Image View',
                                                        style: Styles
                                                            .bold_arsenic_14,
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                          Text(
                                                            "Remaining Gallery Picture View: ${state.accountState!.profileData!.remainingGalleryImageView} times",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Styles
                                                                .regular_gull_grey_12,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          const Text(
                                                            "N.B. Requesting to See This Member Gallery Picture Will Cost 1 From Remaining Gallery Picture View.",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontSize: 10),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                            backgroundColor:
                                                                MyTheme.zircon,
                                                          ),
                                                          child: const Text(
                                                            'Close',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                gradient: Styles.buildLinearGradient(
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment
                                                                        .centerRight)),
                                                            child: const Text(
                                                              'Confirm',
                                                              style: TextStyle(
                                                                  color: MyTheme
                                                                      .white),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            pleaseWaitDialog();
                                                            store.dispatch(
                                                                sendGalleryPictureViewRequestAction(
                                                              id: userId,
                                                            ));
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: MyTheme.light_grey,
                                          gradient: !isAuthUser!
                                              ? Styles.buildLinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight)
                                              : null,
                                        ),
                                        child: Text(
                                          'Send Gallery Photo View Request',
                                          style: Styles.bold_white_12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
    );
  }

  pleaseWaitDialog() {
    return OneContext().showDialog<void>(
      builder: (BuildContext context) {
        store.state.publicProfileState!.loadingContext = context;
        store.state.publicProfileState!.galleryLoadingContext = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.circularIndicator,
              const Text(
                'Please Wait',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
