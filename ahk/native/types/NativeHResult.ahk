/************************************************************************
 * @description 
 * @file NativeHResult.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\native\types\NativeType>

/** 32位整数类型, 这通常与 COM 函数一起使用, 并且仅作为返回类型有效, 没有任何前缀或后缀
 * @classdesc 值范围是0~2147483647
 * @extends {NativeType}
 */
class NativeHResult extends NativeType {
  /** @type {String} HRESULT */
  static Type := NativeType.HRESULT
  __New(Value) {
    super.__New(NativeHResult.Type,Value)
  }
}