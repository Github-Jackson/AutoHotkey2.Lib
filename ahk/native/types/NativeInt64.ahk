/************************************************************************
 * @description 
 * @file NativeInt64.ahk
 * @author Jackson
 * @date 2023/09/08
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativeType>

/** 表示有符号64位整数(Int64) {Int64|Long|Bool}...
 * @extends {NativeType}
 */
class NativeInt64 extends NativeType {
  /** @type {String} Int64 */
  static Type:= NativeType.Int64
  /** 创建一个用于DllCall|NativeCall的64位整数对象
   * @param {Number} Value 有符号64位整数
   */
  __New(Value) {
    super.__New(NativeInt64.Type,Value)
  }
}