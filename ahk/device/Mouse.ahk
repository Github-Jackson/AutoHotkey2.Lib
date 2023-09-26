/************************************************************************
 * @description 
 * @file Mouse.ahk
 * @author Jackson
 * @date 2023/09/18
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\type\Point>

/** Mouse系列内置函数的封装 */
class Mouse {
  /** @prop {Number} DefaultMouseSpeed 没有指定鼠标速度时使用的速度(默认鼠标速度为2),介于0(最快)-100(最慢).
   * 设置在 Click, MouseMove, MouseClick 和 MouseClickDrag 中没有指定鼠标速度时使用的速度.
   */
  static DefaultMouseSpeed {
    get {
      return A_DefaultMouseSpeed
    }
    set {
      SetDefaultMouseSpeed(Value)
    }
  }
  /** @prop {Point} Position 获取和设置鼠标的位置 */
  static Position {
    get {
      return this.GetPos()
    }
    set {
      this.Move(Value)
    }
  }
  /** @prop {Number} 设置每次鼠标动作(移动或单击)后的延迟(毫秒)
   * 时间(单位为毫秒). 指定 -1 表示无延时, 或 0 表示最小延时
   * (然而, 如果使用了 Play 参数, 则 0 和 -1 都表示无延时).
   */
  static Delay {
    get {
      return A_MouseDelay
    }
    set {
      SetMouseDelay(Value)
    }
  }

  static Click() {

  }
  static ClickDrag() {

  }
  static Move(Point) {

  }
  /** 获取鼠标当前位置以及悬停处的窗口ID与控件HWND
   * @param {1|2|3} Flag 如果未设置或省略, 这意味着函数使用默认方法获取控件的 ClassNN. 否则, 请指定以下数字:
   * 1: 使用更简单的方法来获取 Control HWND. 这种方法可以正确获取多文档界面(MDI)
   *   应用程序(例如 SysEdit 或 TextPad) 的活动/顶级子窗口的信息. 
   * 不过, 对于其他的情况(例如获取 GroupBox 控件中的控件) 就没有那么准确了.
   * 2: 把控件的 HWND 保存到 OutputVarControl 而不是控件的 ClassNN.
   * 3: 使上面两个选项都生效(1|2)
   * @returns {Mouse.PositionDesc} 
   */
  static Get(Flag?) {
    return this.PositionDesc(Flag?)
  }
  /** 获取鼠标光标的当前位置
   * @returns {Point} 具备X,Y属性的坐标对象
   */
  static GetPos() {
    MouseGetPos(&x, &y)
    return Point(x, y)
  }
  /** 获取鼠标光标当前位置下的窗口(Window)ID
   * @returns {Number} 窗口(Window)ID
   */
  static GetWindowID() {
    MouseGetPos(, , &id)
    return id
  }
  /** 获取鼠标光标当前位置下的控件(Control)HWND
   * @param {1|2|3} Flag 如果未设置或省略, 这意味着函数使用默认方法获取控件的 ClassNN. 否则, 请指定以下数字:
   * 1: 使用更简单的方法来获取 Control HWND. 这种方法可以正确获取多文档界面(MDI)
   *   应用程序(例如 SysEdit 或 TextPad) 的活动/顶级子窗口的信息. 
   * 不过, 对于其他的情况(例如获取 GroupBox 控件中的控件) 就没有那么准确了.
   * 2: 把控件的 HWND 保存到 OutputVarControl 而不是控件的 ClassNN.
   * 3: 使上面两个选项都生效(1|2)
   * @returns {Number} 控件(Control)HWND
   */
  static GetControlHWND(Flag?) {
    MouseGetPos(, , , &hwnd, Flag?)
    return hwnd
  }
  /**
   * @param {'Alt'|'Slow'|'Alt Slow'|unset} Mode 如果未设置或省略, the pixel is retrieved using the normal method.
   * 否则, 请指定 one个或多个下列单词. 如果含有多个单词, 则它们之间使用空格分隔(例如 "Alt Slow").
   * Alt: 使用另一种方法获取颜色, 当在特殊类型的窗口中正常的方法获取到无效或错误的颜色时, 应考虑使用这种方法. 此方法比正常方法大约慢 10%.
   * Slow: 使用一种更精细复杂的方法获取颜色, 在某些全屏应用程序中其他方法失败时, 此方法可能有效. 此方法比正常方法大约慢三倍. 注: Slow 方法优先于 Alt, 所以此时不需要指定 Alt.
   * @returns {String} Color
   */
  static GetColor(Mode?) {
    pos := this.Position
    return PixelGetColor(pos.X, pos.Y, Mode?)
  }

  class PositionDesc {
    /** @prop {Point} Point 鼠标坐标*/
    Point := unset
    WindowID := unset
    ControlHWND := unset
    __New(Flag?) {
      MouseGetPos(&x, &y, &id, &hwnd, Flag?)
      this.Point := Point(x, y)
      this.WindowID := id
      this.ControlHWND := hwnd
    }
  }

}