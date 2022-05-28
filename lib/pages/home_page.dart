// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:animation_module_assignment/pages/details_page.dart';
import 'package:animation_module_assignment/utils/constants.dart';
import 'package:flutter/material.dart';

const kAnimationDurationForScreenFadeIn = Duration(milliseconds: 1000);
const kAnimationDuration = Duration(milliseconds: 500);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChangedBackgroundColor = false;
  List<String> itemsImages = ["assets/adidas.png", "assets/shoes1.png"];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      duration: kAnimationDuration,
      color: (isChangedBackgroundColor) ? Colors.black : Colors.white,
      child: Stack(
        children: [
          TweenAnimationBuilder(
              duration: kAnimationDurationForScreenFadeIn,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double _value, child) => Opacity(
                    opacity: _value,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: _value * 60,
                          left: MARGIN_MEDIUM_2,
                          right: MARGIN_MEDIUM_2),
                      child: child,
                    ),
                  ),
              child: ProfileAndChangeThemeButtonSectionView(
                isChangedBackgroundColor: isChangedBackgroundColor,
                onTapChangeThemeButton: () {
                  setState(() {
                    isChangedBackgroundColor = !isChangedBackgroundColor;
                  });
                },
              )),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: kAnimationDurationForScreenFadeIn,
            builder: (context, double _value, child) => Opacity(
              opacity: _value,
              child: Padding(
                padding: EdgeInsets.only(
                    left: _value * MARGIN_MEDIUM_2,
                    top: 150,
                    right: MARGIN_MEDIUM_2),
                child: child,
              ),
            ),
            child: TrendingForYouSectionView(
                isChangedBackgroundColor: isChangedBackgroundColor),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: kAnimationDurationForScreenFadeIn,
              builder: (BuildContext context, double value, Widget? child) =>
                  Opacity(
                opacity: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: value * 50,
                      left: MARGIN_MEDIUM_2,
                      right: MARGIN_MEDIUM_2),
                  child: child,
                ),
              ),
              child: RecommendedSectionView(
                isChangedBackgroundColor: isChangedBackgroundColor,
                itemsImages: itemsImages,
                navigate: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailsPage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedSectionView extends StatelessWidget {
  const RecommendedSectionView({
    Key? key,
    required this.isChangedBackgroundColor,
    required this.itemsImages,
    required this.navigate,
  }) : super(key: key);

  final bool isChangedBackgroundColor;
  final List<String> itemsImages;
  final Function navigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: (isChangedBackgroundColor) ? Colors.white : Colors.black,
              fontSize: MARGIN_MEDIUM_2),
        ),
        // SizedBox(height: 16,),
        Container(
          height: 200,
          child: GridView.builder(
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      navigate();
                    },
                    child: ItemsView(
                      images: itemsImages,
                      index: index,
                    ));
              }),
        ),
      ],
    );
  }
}

class ItemsView extends StatelessWidget {
  final List<String> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(images[index]), fit: BoxFit.cover)),
    );
  }

  const ItemsView({Key? key, required this.images, required this.index})
      : super(key: key);
}

class TrendingForYouSectionView extends StatelessWidget {
  const TrendingForYouSectionView({
    Key? key,
    required this.isChangedBackgroundColor,
  }) : super(key: key);

  final bool isChangedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingLabelView(isChangedBackgroundColor: isChangedBackgroundColor),
        const SizedBox(
          height: 24,
        ),
        TrendingView(
          isChangedBackgroundColor: isChangedBackgroundColor,
        ),
      ],
    );
  }
}

class TrendingView extends StatelessWidget {
  final bool isChangedBackgroundColor;

  const TrendingView({Key? key, required this.isChangedBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // color: const Color.fromRGBO(67, 38, 168, 1.0),
        image: const DecorationImage(
          alignment: Alignment.centerRight,
          fit: BoxFit.cover,
          image: AssetImage("assets/adidas.png"),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New 2020",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(145, 102, 203, 1.0),
                    fontSize: MARGIN_MEDIUM_2),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              const Text(
                "Modern Outfit",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: kMARGIN18),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              const Text(
                "Collection",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: kMARGIN18),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Row(
                children: [
                  ProfileImageView(
                      isChangedBackgroundColor: isChangedBackgroundColor,
                      radius: kMARGIN18),
                  SizedBox(
                    width: MARGIN_MEDIUM_2,
                  ),
                  Text(
                    "Firna Surapt",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: MARGIN_MEDIUM),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrendingLabelView extends StatelessWidget {
  const TrendingLabelView({
    Key? key,
    required this.isChangedBackgroundColor,
  }) : super(key: key);

  final bool isChangedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Trending for you",
      style: TextStyle(
          decoration: TextDecoration.none,
          color: (isChangedBackgroundColor) ? Colors.white : Colors.black,
          fontSize: 16),
    );
  }
}

class ProfileAndChangeThemeButtonSectionView extends StatelessWidget {
  const ProfileAndChangeThemeButtonSectionView({
    Key? key,
    required this.onTapChangeThemeButton,
    required this.isChangedBackgroundColor,
  }) : super(key: key);

  final Function onTapChangeThemeButton;
  final bool isChangedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        ProfileImageAndNameView(
            isChangedBackgroundColor: isChangedBackgroundColor),
        const Spacer(),
        ChangeThemeButtonView(
            onTapChangeThemeButton: onTapChangeThemeButton,
            color: (isChangedBackgroundColor) ? Colors.white : Colors.black38)
      ],
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    Key? key,
    required this.isChangedBackgroundColor,
    this.radius = 24.0,
  }) : super(key: key);

  final bool isChangedBackgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImageView(
          isChangedBackgroundColor: isChangedBackgroundColor,
          radius: radius,
        ),
        const SizedBox(
          width: 8,
        ),
        ProfileNameView(isChangedBackgroundColor: isChangedBackgroundColor),
      ],
    );
  }
}

class ChangeThemeButtonView extends StatelessWidget {
  final Function onTapChangeThemeButton;
  final Color color;

  const ChangeThemeButtonView(
      {Key? key, required this.onTapChangeThemeButton, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapChangeThemeButton();
        },
        child: Icon(
          Icons.notifications_active_outlined,
          color: color,
        ));
  }
}

class ProfileNameView extends StatelessWidget {
  const ProfileNameView({
    Key? key,
    required this.isChangedBackgroundColor,
  }) : super(key: key);

  final bool isChangedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Text(
          "Park,",
          style: TextStyle(
            fontSize: 16,
            color: (isChangedBackgroundColor) ? Colors.white60 : Colors.black54,
            decoration: TextDecoration.none,
          ),
        )),
        Flexible(
            child: Text(
          "Roseanne",
          style: TextStyle(
              fontSize: 16,
              color: (isChangedBackgroundColor) ? Colors.white : Colors.black,
              decoration: TextDecoration.none),
        )),
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
    required this.isChangedBackgroundColor,
    required this.radius,
  }) : super(key: key);

  final bool isChangedBackgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: const CircleAvatar(
        backgroundImage: AssetImage(
          "assets/rose.png",
        ),
        radius: 24.0,
      ),
      backgroundColor: (isChangedBackgroundColor) ? Colors.black : Colors.white,
    );
  }
}
