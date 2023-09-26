/************************************************************************
 * @description 
 * @file NativeInt.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativeType>

/** 表示有符号32位整数(Int) {Int|Bool}...
 * @extends {NativeType}
 */
class NativeInt extends NativeType {
  /** @prop {String} Type Int */
  static Type:= NativeType.Int
  /** 创建一个用于DllCall|NativeCall的有符号32位整数对象
   * @param {Number} Value 有符号32位整数
   */
  __New(Value) {
    super.__New(NativeInt.Type,Value)
  }
}