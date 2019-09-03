# flutter_custom_circular_loader

This is a Custom Percentage Widget. With the help of this library you can show you progress in a circular loader, with an animation.

Example
=======================================

```
Widget loader = CustomCircularLoader(
  coveredPercent        : 65,
  circleHeader          : "Total",
  circleSize            : 200.0,
  circleWidth           : 5.0,
  headerInBottom        : true,
  animationDuration     : 1000,
  circleColor           : Colors.grey[100],
  coveredCircleColor    : Colors.red,
  coveredPercentStyle   : TextStyle(
      fontSize  : 44.0,
      fontWeight: FontWeight.w600,
      color     : Colors.red
  ),
  circleHeaderStyle     : TextStyle(
      fontSize  : 22.0,
      fontWeight: FontWeight.w400,
      color     : Colors.grey[900]
  ),
);
```