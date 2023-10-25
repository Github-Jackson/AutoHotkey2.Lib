/************************************************************************
 * @description 
 * @file Promise.ahk
 * @author Jackson
 * @date 2023/09/25
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\lang\Proxy>

class Promise {
  /**
   * 
   * @param {PromiseExecutory} Executory 
   */
  __New(Executory) {
    Resolve(Data) {
      return this
    }
    Reject(Value) {
      
    }
    Executory(Resolve,Reject)
  }

  /**
   * 
   * @param {(Result)=>Any} PromiseCallback 
   * @returns {Promise} 
   */
  Then(PromiseCallback) {
    return this
  }

  /**
   * 
   * @param {(Error)=>Any} ErrorCallback 
   */
  Catch(ErrorCallback){

  }
  Finally(){
    return this
  }
}
