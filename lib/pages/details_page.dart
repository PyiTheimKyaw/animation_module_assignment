// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:animation_module_assignment/data/vos/size_vo.dart';
import 'package:animation_module_assignment/utils/constants.dart';
import 'package:flutter/material.dart';

const kAnimationDuration = Duration(milliseconds: 500);
const kAnimationDurationForFavourite = const Duration(milliseconds: 1000);

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationControllerForFavIcon;

  late Animation<Color?> colorAnimation;

  bool isAnimationCompleted = true;
  bool isDescriptionShown = true;
  List<SizeVO> size = [
    SizeVO(size: "S"),
    SizeVO(size: "M"),
    SizeVO(size: "L"),
    SizeVO(size: "XL"),
    SizeVO(size: "XXL"),
  ];
  bool isSizeSelected = false;
  double turn = 0.0;

  @override
  void initState() {
    _animationControllerForFavIcon = AnimationController(
      vsync: this,
      duration: kAnimationDurationForFavourite,
    );
    colorAnimation = ColorTween(begin: Colors.white, end: Colors.red)
        .animate(_animationControllerForFavIcon.view);

    super.initState();
  }

  @override
  void dispose() {
    _animationControllerForFavIcon.dispose();
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
              animationController: _animationControllerForFavIcon,
              colorAnimation: colorAnimation,
              onTapFav: () {
                setState(() {
                  isAnimationCompleted = !isAnimationCompleted;
                  if (isAnimationCompleted) {
                    _animationControllerForFavIcon.reverse();
                  } else {
                    _animationControllerForFavIcon.forward();
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: ItemDetailsSectionView(
                turn: turn,
                isDescriptionShown: isDescriptionShown,
                controllerForSize: size,
                onTapShowDescription: () {
                  setState(() {
                    turn += 0.5;
                    isDescriptionShown = !isDescriptionShown;
                  });
                },
                isSizeSelected: isSizeSelected,
                onTapSize: (index) {
                  setState(() {
                    size[index].isSelected = !(size[index].isSelected ?? false);
                  });
                },
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDetailsSectionView extends StatelessWidget {
  ItemDetailsSectionView(
      {required this.isDescriptionShown,
      required this.onTapShowDescription,
      required this.size,
      required this.isSizeSelected,
      required this.onTapSize,
      required this.turn,
      required this.controllerForSize});

  final bool isDescriptionShown;
  final Function onTapShowDescription;

  final List<SizeVO> controllerForSize;

  final List<SizeVO>? size;
  final Function(int) onTapSize;
  final bool isSizeSelected;

  final double turn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Adidas Shoes",
          style: (TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Text(
          "\$ 19,39",
          style: TextStyle(color: Colors.purple, fontSize: MARGIN_MEDIUM_2),
        ),
        SizedBox(
          height: kMARGIN18,
        ),
        DescriptionAndExpandIconView(
            turn: turn, onTapShowDescription: onTapShowDescription),
        SizedBox(
          height: kMARGIN18,
        ),
        ItemDescriptionView(isDescriptionShown: isDescriptionShown),
        SizedBox(
          height: kMARGIN18,
        ),
        SizeLabelView(),
        Container(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
              padding: EdgeInsets.only(left: MARGIN_MEDIUM - 7),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizeItemView(
                  size: size?[index],
                  index: index,
                  isSizeSelected: size?[index].isSelected ?? false,
                  onTapSize: onTapSize,
                );
              }),
        )
      ],
    );
  }
}

class SizeItemView extends StatelessWidget {
  SizeItemView({
    required this.size,
    required this.index,
    required this.onTapSize,
    this.isSizeSelected = false,
  });

  final SizeVO? size;
  final int index;
  final Function(int) onTapSize;
  final bool isSizeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onTapSize(index);
          },
          child: AnimatedContainer(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: isSizeSelected ? Colors.purple : Colors.white,
              ),
              duration: kAnimationDuration,
              child: Center(child: Text(size?.size ?? ""))),
        ),
        SizedBox(
          width: kMARGIN18,
        )
      ],
    );
  }
}

class SizeLabelView extends StatelessWidget {
  const SizeLabelView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Size your size",
          style: TextStyle(fontSize: kMARGIN18),
        ),
        Spacer(),
        Text(
          "Size Guide",
          style: TextStyle(color: Colors.purple),
        ),
      ],
    );
  }
}

class ItemDescriptionView extends StatelessWidget {
  const ItemDescriptionView({
    Key? key,
    required this.isDescriptionShown,
  }) : super(key: key);

  final bool isDescriptionShown;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: kAnimationDuration,
      child: Container(
        width: double.infinity,
        height: (isDescriptionShown) ? null : 0.0,
        child: Text(
          "Through sports, we have the power to change lives. Sports keep us fit. They keep us mindful. They bring us together. Athletes inspire us. They help us to get up and get moving. And sporting goods featuring the latest technologies help us beat our personal best.",
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}

class DescriptionAndExpandIconView extends StatelessWidget {
  const DescriptionAndExpandIconView({
    Key? key,
    required this.onTapShowDescription,
    required this.turn,
  }) : super(key: key);

  final Function onTapShowDescription;
  final double turn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Description",
          style: TextStyle(fontSize: kMARGIN18),
        ),
        Spacer(),
        AnimatedRotation(
          turns: turn,
          duration: kAnimationDuration,
          child: IconButton(
            icon: Icon(Icons.expand_more, size: 32),
            onPressed: () {
              onTapShowDescription();
            },
          ),
        ),
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
                      return RotationTransition(
                        turns: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(_animationController),
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
