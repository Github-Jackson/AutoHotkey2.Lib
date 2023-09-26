/************************************************************************
 * @description 
 * @file Point.ahk
 * @author Jackson
 * @date 2023/09/18
 * @version 0.0.1
 ***********************************************************************/
/** 表示具备X和Y属性的坐标类 */
class Point {
  /** @prop {Number} X X轴坐标 */
  X: i64
  /** @prop {Number} Y Y轴坐标 */
  Y: i64
  /** 实例化一个坐标描述对象
   * @param {Number} X X轴坐标
   * @param {Number} Y Y轴坐标
   */
  __New(X := 0, Y := 0) {
    this.X := X
    this.Y := Y
  }
}