import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/textfield.dart';

class CircularPic extends StatelessWidget {
  final double diameter;
  final String? image;
  final BorderSide border;
  final ImageType imageType;
  const CircularPic({Key? key,required this.diameter, this.image=AssetPath.IMAGE_SAMPLE,
    this.imageType=ImageType.TYPE_ASSET,
    this.border = const BorderSide(width: 0,
        color: AppColor.COLOR_TRANSPARENT)}):super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle, border: Border.fromBorderSide(border),),
      child: ClipOval(
          child: CustomImage(
            image: image,imageType: imageType,fit: BoxFit.cover,
          )),
    );
  }
}

class EditProfilePicture extends CircularPic{

  final void Function()? onEdit;
  EditProfilePicture({double? diameter,String? image=AssetPath.IMAGE_SAMPLE2,
    BorderSide border=BorderSide.none,
    ImageType imageType=ImageType.TYPE_ASSET,this.onEdit,}):
        super(diameter: diameter??AppSizer.getHeight(AppDimen.PROFILE_PIC_DIAM),
          image: image,imageType: imageType,
          border: border);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: diameter,height: diameter,
        child: Stack(
          children: [
            super.build(context),
            Positioned(
              right: 0,bottom: 0,
              child: Visibility(
                visible: onEdit!=null,
                child: CircularButton(diameter: diameter*0.22,
                  icon: AssetPath.ICON_CAMERA,ratio: 0.5,
                  border: const BorderSide(width: 1,color: AppColor.THEME_COLOR_PRIMARY1),
                  onTap: onEdit, color: AppColor.THEME_COLOR_PRIMARY1,),
              ),
            ),
          ],
        ));
  }

}

class EditField extends LineField{

  final void Function()? onEditTap;
  EditField({TextEditingController? controller,String hinttext="",this.onEditTap,}):
        super(controller: controller,hinttext: hinttext,
        border: const BorderSide(width: 2,color: AppColor.COLOR_BLACK),);


  @override
  Widget? get suffixIcon {
    final double iconsize=AppSizer.getHeight(12);
    return GestureDetector(onTap: onEditTap,
        child:Container(color: AppColor.COLOR_TRANSPARENT,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_ICON_HORZ_PADDING),),
          child: SizedBox(
              width: iconsize,height: iconsize,
              child: Center(
                child: CustomMonoIcon(
                  icon: AssetPath.ICON_EDIT,
                  color: AppColor.COLOR_BLACK,size: iconsize,),
              )),
        )
    );
  }

  @override
  EdgeInsets get contentPadding => EdgeInsets.symmetric(
      horizontal:super.contentPadding.left,
      vertical: AppSizer.getHeight(10)
  );

}
