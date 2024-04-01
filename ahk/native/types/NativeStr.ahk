/************************************************************************
 * @description 
 * @file NativeStr.ahk
 * @author Jackson
 * @date 2023/09/08
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativeType>

/** 表示字符串类型;
 * 很少使用的 Str* 参数类型传递包含字符串地址的临时变量的地址.
 * 如果函数将新地址写入临时变量, 
 * 则将新字符串复制到脚本变量, 
 * if a VarRef was passed. 
 * 它可以用在期望 "TCHAR **" 或 "LPTSTR *" 类型参数的函数中. 
 * 但是, 如果函数分配了内存并希望调用者释放它(例如通过调用 CoTaskMemFree ¬),
 * 则必须改用 Ptr* 参数类型.
 * @extends {NativeType}
 */
class NativeStr extends NativeType {
  /** @type {String} Str */
  static Type := NativeType.Str

  /** 创建一个用于DllCall|NativeCall的原生字符串对象
   * @param {String} Value 字符串
   */
  __New(Value) {
    super.__New(NativeStr.Type, Value)
  }
}