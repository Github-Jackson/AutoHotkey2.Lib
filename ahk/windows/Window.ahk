/************************************************************************
 * @description 
 * @file Window.ahk
 * @author Jackson
 * @date 2023/09/20
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\windows\WindowPack>
/** 窗口类, 通过窗口ID(HWND)操作窗口;实例化时保存目标窗口ID(HWND)
 * 若要根据WinTitle匹配模式操作窗口请使用{WinMatch}
 * @extends {WindowPack}
 */

class Window extends WindowPack {
  /** @prop {Number} HWND */
  HWND := unset
  /** 实例化窗口对象, 保存目标窗口ID(HWND)
   * @overload (HWND)
   * @param {Number} HWND 窗口ID(HWND)
   * @param {'A'|String|Number} Title 窗口匹配条件(WinTitle)或窗口ID(HWND)
   */
  __New(Title := 'A') {
    if(Title is Number){
      this.HWND := Title
    }else{
      this.HWND := WinExist(Title)
    }
  }
}
