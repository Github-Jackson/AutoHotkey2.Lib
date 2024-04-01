/************************************************************************
 * @description 
 * @file NativeUInt.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativeType>

/** 表示无符号32位整数(UInt) {UInt|DWORD}...
 * @extends {NativeType}
 */
class NativeUInt extends NativeType {
  /** @type {String} UInt */
  static Type:= NativeType.UInt
  /** 创建一个用于DllCall|NativeCall的无符号32位整数对象
   * @param {Number} Value 无符号32位整数
   */
  __New(Value) {
    super.__New(NativeUInt.Type,Value)
  }
}