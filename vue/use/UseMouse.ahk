/************************************************************************
 * @description 
 * @file UseMouse.ahk
 * @author Jackson
 * @date 2023/10/19
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\type\Point>
#Include <ahk\async\Timer>
#Include <vue\Reactive>
#Include <ahk\device\Mouse>

/** 暂时无法正常使用 */
UseMouse(){
  /** @type {Point} */
  static MOUSE_POINT := Reactive(Point())
  /** @type {Timer} */
  static MONITOR := Timer((){
    pos := Mouse.Position
    MOUSE_POINT.X := pos.X
    MOUSE_POINT.Y := pos.Y
  },16,0)
  ; return MOUSE_POINT
}
