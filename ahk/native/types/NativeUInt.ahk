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
  /** @prop {String} Type UInt */
  static Type:= NativeType.UInt
  /**
   * @param {Number} Value 无符号32位整数
   */
  __New(Value) {
    super.__New(NativeUInt.Type,Value)
  }
}