/************************************************************************
 * @description 
 * @file React.ahk
 * @author Jackson
 * @date 2023/10/25
 * @version 0.0.1
 ***********************************************************************/
#Include <vue\Vue>

/**
 * 实现一个
 */
class React {
  static __New() {
    this.DefineProp('Call', {
      Call: (this, Params*) {
        target := {}
        target.Base := this.Prototype
        target.__Init()
        target.__New(Params*)
        result := React.Object(target)
        for (prop, val in target.OwnProps()) {
          if (HasMethod(val)) {
            Vue(val.Bind(result))
          }
        }
        return result
      }
    })
  }

  class Object extends Object {
    __New(Target) {
      this.DefineProp('__Raw', {
        Value: Target
      })
    }
    __Get(Key, Params) {
      Vue.Vue.Effect(this, Key)
      return this.__Raw.%Key%
    }
    __Set(Key, Params, Value) {
      this.__Raw.%Key% := Value
      Vue.Vue.Update(this, Key)
    }
    __Call(Name, Params) {
      if (this.__Raw.HasMethod(Name)) {
        Vue(this.__Raw.GetMethod(Name).Bind(this))
      }
    }
  }
}

class ReactTest extends React {
  /** 响应式的Prop */
  Prop := 'unset'
  Test := 'tooltip'
  __New() {
    return this
  }
  /** 响应式的Msgbox */
  ReactProp := (this, title := 'reack') {
    MsgBox(this.Prop,)
  }
  /** 响应式的ToolTip */
  ReactTooltip := (this) {
    ToolTip(this.Test)
  }
}

(() {
  var := ReactTest()
  var.Prop := 'ssss'
  var.ReactProp
  Async(() {
    var.Test := 'ceshi tooltip'
    var.Prop := 'double'
  }, 500)
})()