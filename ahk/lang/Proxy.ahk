/************************************************************************
 * @description 
 * @file Proxy.ahk
 * @author Jackson
 * @date 2023/09/26
 * @version 0.0.1
 ***********************************************************************/

/** 构建一个代理对象 */
class Proxy {
  __New(Target) {
    this.DefineProp('__Get', {
      Call: (this, Key, Params) {
        if(Key == 'this') {
          return Target
        }
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

