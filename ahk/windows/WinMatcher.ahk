/************************************************************************
 * @description 
 * @file WinMatcher.ahk
 * @author Jackson
 * @date 2023/09/23
 * @version 0.0.0
 ***********************************************************************/

class WinMatcher {

  /** 在{Hidden}指定的隐藏窗口检测环境中执行{Action}并返回执行结果, 而后复原DetectHidden环境;
   * 
   * 若仅提供第一个参数为Bool, 则设置A_DetectHiddenWindows,A_DetectHiddenText
   * @overload (Hidden) => $WinMatcher
   * @param {()=>Any} Action 
   * @param {Boolean} Hidden 
   * @returns {$WinMatcher|*} 若Action为Bool,返回this;否则返回Action()的执行结果
   */
  static DetectHidden(Action := true, Hidden := true) {
    if (HasMethod(Action)) {
      dWin := A_DetectHiddenWindows,
        dText := A_DetectHiddenText,
        A_DetectHiddenWindows := A_DetectHiddenText := Hidden,
        result := Action(),
        A_DetectHiddenWindows := dWin,
        A_DetectHiddenText := dText
      return result
    }else {
      A_DetectHiddenWindows := A_DetectHiddenText := Action
      return this
    }
  }
  /** 在{Hidden}指定的DetectHiddenWindows(DetectHiddenText设置为!{Hidden})
   * 检测环境中执行{Action}并返回执行结果, 而后复原DetectHidden环境;
   * 
   * 若仅提供第一个参数为Bool, 则设置A_DetectHiddenWindows
   * @overload (Hidden) => $WinMatcher
   * @param {()=>Any} Action 
   * @param {Boolean} Hidden 
   * @returns {$WinMatcher|*}
   */
  static DetectHiddenWindows(Action := true, Hidden := true) {
    if (HasMethod(Action)) {
      dWin := A_DetectHiddenWindows,
        dText := A_DetectHiddenText,
        A_DetectHiddenText := !A_DetectHiddenWindows := Hidden,
        result := Action(),
        A_DetectHiddenWindows := dWin,
        A_DetectHiddenText := dText
      return result
    }else {
      A_DetectHiddenWindows := Action
      return this
    }
  }
  /** 在{Hidden}指定的DetectHiddenText(DetectHiddenWindows设置为!{Hidden})
   * 检测环境中执行{Action}并返回执行结果, 而后复原DetectHidden环境;
   * 
   * 若仅提供第一个参数为Bool, 则设置A_DetectHiddenWindows
   * @overload (Hidden) => $WinMatcher
   * @param {()=>Any} Action 
   * @param {Boolean} Hidden 
   * @returns {$WinMatcher|*}
   */
  static DetectHiddenText(Action, Hidden := true) {
    if (HasMethod(Action)) {
      dWin := A_DetectHiddenWindows,
        dText := A_DetectHiddenText,
        A_DetectHiddenWindows := !A_DetectHiddenText := Hidden,
        result := Action(),
        A_DetectHiddenWindows := dWin,
        A_DetectHiddenText := dText
      return result
    }else {
      A_DetectHiddenText := Action
      return this
    }
  }
}