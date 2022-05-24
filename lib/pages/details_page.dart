// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:animation_module_assignment/utils/constants.dart';
import 'package:flutter/material.dart';

const kAnimationDurationForFavourite = const Duration(milliseconds: 1000);

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> colorAnimation;
  bool isAnimationCompleted = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: kAnimationDurationForFavourite);
    colorAnimation = ColorTween(begin: Colors.white, end: Colors.red)
        .animate(_animationController.view);
    // _animationController.addStatusListener((status) {
    //   isAnimationCompleted = (status == AnimationStatus.completed);
    //   // _animationController.repeat();
    // });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemProfileSecrionView(
              animationController: _animationController,
              colorAnimation: colorAnimation,
              onTapFav: () {
                setState(() {
                  isAnimationCompleted = !isAnimationCompleted;
                  if (isAnimationCompleted) {
                    _animationController.reset();
                  } else {
                    _animationController.repeat();
                  }
                  // _animationController..reverse(from: 0.8);
                });
              },
            ),
            ItemDetailsSectionView(),
          ],
        ),
      ),
    );
  }
}
class ItemDetailsSectionView extends StatelessWidget {
  const ItemDetailsSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Adidas Shoes",style: (TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),),
        SizedBox(height: MARGIN_MEDIUM_2,),
        Text("\$ 19,39",style: TextStyle(color: Colors.purple,fontSize: MARGIN_MEDIUM_2),),

        
      ],
    );
  }
}

class ItemProfileSecrionView extends StatelessWidget {
  const ItemProfileSecrionView({
    Key? key,
    required AnimationController animationController,
    required this.colorAnimation,
    required this.onTapFav,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final Animation<Color?> colorAnimation;
  final Function onTapFav;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: [
          BackgroundItemImageSectionView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedContainerSectionView(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: NavigatePopButtonSectionView(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _animationController.view,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _animationController.value * 6.3,
                        child: FavouriteIconButtonVIew(
                          onTapFav: () {
                            onTapFav();
                          },
                          color: colorAnimation.value,
                        ),
                      );
                    },
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NavigatePopButtonSectionView extends StatelessWidget {
  const NavigatePopButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class CurvedContainerSectionView extends StatelessWidget {
  const CurvedContainerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
    );
  }
}

class BackgroundItemImageSectionView extends StatelessWidget {
  const BackgroundItemImageSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      padding: EdgeInsets.only(top: kMARGIN18),
      // height: 300,
      width: double.infinity,
      child: Image(
        image: AssetImage("assets/adidas.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}

class FavouriteIconButtonVIew extends StatelessWidget {
  const FavouriteIconButtonVIew({
    Key? key,
    required this.onTapFav,
    required this.color,
  }) : super(key: key);
  final Function onTapFav;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          onTapFav();
        },
        icon: Icon(
          Icons.favorite,
          color: color,
        ));
  }
}
