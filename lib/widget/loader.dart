import 'package:flutter/material.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/button.dart';

class ProcessLoading extends StatefulWidget{

  final bool dismissible;
  const ProcessLoading({this.dismissible=true,});

  @override
  State createState() {
    return _ProcessLoadingState();
  }
}

class _ProcessLoadingState extends State<ProcessLoading> with SingleTickerProviderStateMixin{

  late AnimationController _cont;
  late Animation<Color?> _anim;

  @override
  void initState() {
    _cont=AnimationController(duration: const Duration(seconds: 1,),vsync: this);
    _cont.addListener(() {
      setState(() {
        //print("val: "+_cont.value.toString());
      });
    });
    ColorTween col=ColorTween(begin: Colors.blue,end:Colors.pink);
    _anim=col.animate(_cont);
    _cont.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double padd=AppDimen.BTN_CLOSE_PADDING;
    return WillPopScope(
      onWillPop: () async{
        return widget.dismissible;
      },
      child: Material(color: AppColor.COLOR_TRANSPARENT,
        child: Container(color:const Color.fromRGBO(0, 0, 0, 0.5),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: widget.dismissible,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: padd,right: padd),
                      child: ButtonClose(color: AppColor.COLOR_WHITE,
                        diameter: AppSizer.getHeight(20),
                        onTap: (){
                          AppLoader.dismissLoader();
                        },),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(width: 50*_cont.value,height: 50*_cont.value,
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(_anim.value,),)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class ContentLoading extends StatefulWidget{

  final double diameter;
  const ContentLoading({this.diameter=30,});

  @override
  State createState() {
    return _ContentLoadingState();
  }
}

class _ContentLoadingState extends State<ContentLoading> with SingleTickerProviderStateMixin{

  late AnimationController _cont;
  late Animation<Color?> _anim;

  @override
  void initState() {
    _cont=AnimationController(duration: const Duration(seconds: 1,),vsync: this);
    _cont.addListener(() {
      setState(() {
        //print("val: "+_cont.value.toString());
      });
    });
    ColorTween col=ColorTween(begin: Colors.blue,end:Colors.pink);
    _anim=col.animate(_cont);
    _cont.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _cont.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: widget.diameter,height: widget.diameter,
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(_anim.value,),)),
    );
  }
}