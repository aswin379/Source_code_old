import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/style.dart';
import '../helpers/navigator_push.dart';
import '../screens/core.dart';
import '../screens/happy_story/happy_stories_details.dart';
import '../screens/home_pages/explore/explore_action.dart';
import 'common_widget.dart';
import 'my_images.dart';

class HappyStoriesCard extends StatelessWidget {
  final bool? isFetching;
  final List? happyStories;
  final CarouselSliderController? controller;
  final happyStoriesIndex;

  const HappyStoriesCard(
      {super.key,
      this.isFetching,
      this.happyStories,
      this.controller,
      this.happyStoriesIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 235,
          child: isFetching!
              ? CommonWidget.circularIndicator
              : happyStories!.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: happyStories!.length,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                            onTap: () {
                              NavigatorPush.push(
                                context,
                                HappyStoriesDetails(
                                  data: happyStories![index],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MyImage.imageProvider(
                                      happyStories![index].thumbImg),
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0.4,
                                      1,
                                    ],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // named row
                                      Text(
                                        happyStories![index].title,
                                        style: Styles.bold_white_16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      //member id row
                                      Text(
                                        happyStories![index].details,
                                        style: Styles.regular_light_grey_12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          store.dispatch(
                            SetExploreHappyStoriesCarouselIndex(payload: index),
                          );
                        },
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                    )
                  : CommonWidget.noData,
        ),
        Positioned(
          bottom: 12,
          child: AnimatedSmoothIndicator(
            effect: ExpandingDotsEffect(
                dotColor: Colors.white.withOpacity(0.3),
                activeDotColor: Colors.white.withOpacity(0.2),
                dotHeight: 8,
                dotWidth: 8),
            activeIndex: happyStoriesIndex,
            count: happyStories!.length,
          ),
        )
      ],
    );
  }
}
