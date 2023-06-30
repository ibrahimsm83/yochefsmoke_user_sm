import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/icons.dart';

class StarRating extends StatelessWidget {

  late double _size;
  final double spacing;
  final double rating;
  final bool enabled;
  final Color color;
  final void Function(double val)? onRatingUpdate;
  StarRating({Key? key,double? size,this.spacing=2,this.rating=1,this.enabled=true,
    this.color=AppColor.THEME_COLOR_PRIMARY1,
    this.onRatingUpdate,}) : super(key: key){
    _size=size??AppSizer.getHeight(12);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: RatingBar.builder(
      initialRating: rating,ignoreGestures: onRatingUpdate==null,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: _size,
      unratedColor: color,
      itemPadding: EdgeInsets.symmetric(horizontal: spacing),
      itemBuilder: (context, ind) {
        final double index=ind+1;
        return CustomMonoIcon(
          color: color,
          icon: rating>=(index)?AssetPath.ICON_STAR_FILLED:(rating+0.5)==index?
          AssetPath.ICON_STAR_HALF:
          AssetPath.ICON_STAR,
        );
      },
      onRatingUpdate: (val){
        onRatingUpdate?.call(val);
      },
    ),);
  }
}