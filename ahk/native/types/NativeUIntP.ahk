/************************************************************************
 * @description 
 * @file NativeUIntP.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativePointer>

/** 表示无符号32位整数(UInt)类型的指针 {UInt*|LPDWORD}...
 * @extends {NativePointer}
 */
class NativeUIntP extends NativePointer {
  /** @type {String} UInt* */
  static Type:= NativeType.UIntP
  /**
   * @param {Number} Value 无符号32位整数
   */
  __New(Value) {
    super.__New(NativeUIntP.Type,Value)
  }
}