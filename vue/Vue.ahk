/************************************************************************
 * @description 
 * @file Vue.ahk
 * @author Jackson
 * @date 2023/10/19
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\lang\Proxy>
#Include <ahk\async\Async>

;scheduler track trigger

class Vue {
  /** @prop {Array} Effect */
  static Effect := unset
  /** @prop {Vue} Vue */
  static Vue := unset
  /** @prop {Map} Subscriptions */
  static Subscriptions := unset

  static __New() {
    Vue.Effect := []
    Vue.Subscriptions := Map()
    Vue.Vue := {}
    Vue.Vue.Base := Vue.Prototype
    Vue.Vue.__Init()
    Vue.Vue.__New()
  }
  __New() {

  }
  static Call(Call) {
    this.Effect.Push(Call)
    Call()
    this.Effect.Pop()
    return Vue.Vue
  }
  /** @prop {Boolean} Updating 用于标识是否在Vue 响应式 Update态中 */
  ; Updating := false

  /**
   * 副作用收集, 将当前Effect订阅Source的响应式更新
   * @param {Any} Source 订阅源
   * @param {String} Key 订阅源的属性Key
   * @returns {void} 
   */
  Effect(Source, Key := 'Value') {
    /** 若当前处于Vue Updating中, 不收集副作用 ? 暂不实现 */
    local len := Vue.Effect.Length
    if (len == 0) {
      return
    }
    if (Vue.Subscriptions.Has(Source)) {
      /** @type {Map} */
      Subscription := Vue.Subscriptions.Get(Source)
      if (Subscription.Has(Key)) {
        Subscription.Get(Key).Push(Vue.Effect[len])
      } else {
        Subscription.Set(Key, [Vue.Effect[len]])
      }
    } else {
      Vue.Subscriptions.Set(Source, Map(Key, [Vue.Effect[len]]))
    }
  }
  /** 触发Source异步响应式更新, 调用相关的副作用 */
  Update(Source, Key := 'Value') {
    /** 收集响应式更新函数 */
    static AsyncUpdate := 0, AsyncUpdates := Map()
    TriggerUpdate() {
      AsyncUpdate := 0, Updates := AsyncUpdates, AsyncUpdates := Map()
      for (key, value in Updates) {
        value()
      }
    }
    /** 若已经存在Source对应的更新任务 */
    if (Vue.Subscriptions.Has(Source) && Vue.Subscriptions.Get(Source).Has(Key)) {
      local Subscription := Vue.Subscriptions.Get(Source).Get(Key)
      for (index, item in Subscription) {
        AsyncUpdates.Set(item, item)
      }
      /** 创建异步更新, 在当前线程执行完后触发响应式更新 */
      if (AsyncUpdate == 0) {
        AsyncUpdate := Async(TriggerUpdate)
      }
    }
  }

  class Object {

  }
  class Reactive extends Vue.Object {
    __New(Target) {
      this.DefineProp('__Raw',{
        Value : Target
      })
    }
    __Get(Key, Params) {
      Vue.Vue.Effect(this, Key)
      return this.__Raw.%Key%[Params*]
    }
    __Set(Key, Params, Value) {
      this.__Raw.%Key%[Params*] := Value
      Vue.Vue.Update(this, Key)
    }
    __Call(Name, Params) {
      return this.__Raw.%Name%.Call(this, Params*)
    }
    __Enum(NumberOfVars) {
      return this.__Raw.__Enum(NumberOfVars)
    }
    OwnProps(){
      enumerator := this.__Raw.OwnProps()
      return (&prop,&val){
        if(result := enumerator(&prop))
          val := this.%prop%
        return result
      }
    }
  }

  class Proxy extends Proxy {
    __New(Target) {

      this.Clone()
      this.DeleteProp() ;测试delete 子类方法或者属性是否就变成访问父类
    }
  }
  /** 构建响应式对象, 通过.Value访问和设置响应式, 一般用于Number,String等非对象类型的Reactive */
  class Ref extends Vue.Object {
    __New(Value) {
      this.DefineProp('Value', {
        Get: (*) {
          Vue.Vue.Effect(this)
          return Value
        },
        Set: (this, _Value) {
          if (Value != _Value) {
            Value := _Value
            Vue.Vue.Update(this)
          }
        }
      })
    }
    OwnProps(){
      return (&prop,&val){
        prop := 'Value',val := this.Value
        return 0
      }
    }
  }
}