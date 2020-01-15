import 'package:flutter/material.dart';

class JCustomIndicator extends StatelessWidget {
  // Pageview控制器
  final PageController controller; 
  // 指示器个数
  final int itemCount;
  // 普通颜色
  final Color normalColor = Colors.grey;
  // 选中颜色
  final Color selectColor = Colors.black;
  // 大小
  final double size = 8.0;
  // 间距
  final double spacing = 4.0;

  JCustomIndicator({
    this.controller,
    this.itemCount = 0,
  }):assert(controller != null);

  // Widget
  Widget _buildIndicator(int index, int pageCount, double dotSize, double spacing){

    // 是否当前页面被选中
    bool isCurrentPageSelected = index == (controller.page != null ? controller.page.round() % pageCount : 0);
    return Container(
      height: size,
      width: size + (2 * spacing),
      child: Center(
        child: Material(
          color: isCurrentPageSelected ? selectColor : normalColor,
          type: MaterialType.circle,
          child: Container(
            width: dotSize,
            height: dotSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index){
        return _buildIndicator(index, itemCount, size, spacing);
      })
    );
  }
}

