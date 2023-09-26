#Include <ahk\native\types\NativeType>

/** 用于描述NativeCall中返回值类型, Cdecl调用约定请使用{NativeReturnType.Cdecl}
 * @extends {NativeType}
 */
class NativeReturnType extends NativeType {

  /** 用于描述包含[cdecl]调用约定的返回值类型.
   * @extends {NativeType}
   */
  class Cdecl extends NativeType {
    static __New() {
      _GetBasePropValue(Prop,this){
        return 'cdecl ' this.Base.%Prop%
      }
      for (prop, val in NativeType.OwnProps()) {
        value := val
        this.DefineProp(prop, {
          Get: _GetBasePropValue.Bind(prop)
        })
      }
    }

    static __Get(Key, Params) {
      if (super.HasProp(Key)) {
        this._GetSuperPropValue(Key, Params)
      }
    }
  }
}