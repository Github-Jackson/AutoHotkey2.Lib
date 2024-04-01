/************************************************************************
 * @description 
 * @file NativePointer.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\native\types\NativeType>

class NativePointer extends NativeType {

  /** @type {VarRef} 指向(this.Value)的指针 */
  Pointer := unset
  /**
   * @param {String} Type  Str | WStr | AStr | Int64 | Int | Short |
   * Char | Float | Double | Ptr | (Type* | TypeP) | UNumber | HRESULT
   * @param {Number|String|Buffer} Value 对应的值
   */
  __New(Type,Value) {
    super.__New(Type,Value)
    this.Pointer := &Value
    this.DefineProp('Value',{
      Get: (this) => Value,
      Set: (this,newValue) => Value := newValue
    })
  }
}