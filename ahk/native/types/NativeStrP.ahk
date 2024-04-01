/************************************************************************
 * @description 
 * @file NativeStrP.ahk
 * @author Jackson
 * @date 2023/09/08
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativePointer>

/** 表示字符串指针类型; 
 * 它可以用在期望 "TCHAR **" 或 "LPTSTR *" 类型参数的函数中. 
 * 但是, 如果函数分配了内存并希望调用者释放它(例如通过调用 CoTaskMemFree ¬),
 * 则必须改用 Ptr* 参数类型.
 * @extends {NativePointer}
 */
class NativeStrP extends NativePointer {
  /** @type {String} StrP */
  static Type := NativeType.StrP

  /** 创建一个用于DllCall|NativeCall的原生字符串对象
   * @param {String} Value 字符串
   */
  __New(Value) {
    super.__New(NativeStrP.Type, Value)
  }
}