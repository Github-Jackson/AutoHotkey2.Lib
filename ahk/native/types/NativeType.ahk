/************************************************************************
 * @description 
 * @file NativeType.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

/** 用于DllCall的类型值对 */
class NativeType {
  /** @prop {String} Type 类型 */
  Type := unset
  /** @prop {Number|String|Buffer} Value 值 */
  Value := unset
  /**
   * @param {String} Type  Str | WStr | AStr | Int64 | Int | Short |
   * Char | Float | Double | Ptr | (Type* | TypeP) | UNumber | HRESULT
   * @param {Number|String|Buffer} Value 对应的值
   */
  __New(Type, Value) {
    this.Type := Type, this.Value := Value
  }

  /** 返回(this.Value)
   * @returns {Any} this.Value 
   */
  Call() {
    return this.Value
  }

  ;#region Native Types

  static Str      := 'Str'
  static WStr     := 'WStr'
  static AStr     := 'AStr'
  static Int64    := 'Int64'
  static Int      := 'Int'
  static Short    := 'Short'
  static Char     := 'Char'
  static Float    := 'Float'
  static Double   := 'Double'
  static Ptr      := 'Ptr'

  static StrP     := 'Str*'
  static WStrP    := 'WStr*'
  static AStrP    := 'AStr*'
  static Int64P   := 'Int64*'
  static IntP     := 'Int*'
  static ShortP   := 'Short*'
  static CharP    := 'Char*'
  static FloatP   := 'Float*'
  static DoubleP  := 'Double*'
  static PtrP     := 'Ptr*'

  static UInt64   := 'UInt64'
  static UInt     := 'UInt'
  static UShort   := 'UShort'
  static UChar    := 'UChar'

  static UInt64P   := 'UInt64*'
  static UIntP     := 'UInt*'
  static UShortP   := 'UShort*'
  static UCharP    := 'UChar*'

  static HRESULT := 'HRESULT'
  ;#endregion
}