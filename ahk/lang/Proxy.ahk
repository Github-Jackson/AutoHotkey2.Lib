/************************************************************************
 * @description 
 * @file Proxy.ahk
 * @author Jackson
 * @date 2023/09/26
 * @version 0.0.1
 ***********************************************************************/

/** 构建代理 */
class Proxy {
  /** 构建{Target}代理对象 */
  __New(Target) {
    this.DefineProp('__Get', {
      Call: (this, Key, Params) {
        return Target.%Key%[Params*]
      }
    })
    this.DefineProp('__Set', {
      Call: (this, Key, Params, Value) {
        Target.%Key%[Params*] := Value
      }
    })
    this.DefineProp('__Call', {
      Call: (this, Name, Params) {
        return Target.%Name%(Params*)
      }
    })
  }
}

