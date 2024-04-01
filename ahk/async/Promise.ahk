/************************************************************************
 * @description 
 * @file Promise.ahk
 * @author Jackson
 * @date 2023/09/25
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\lang\Proxy>
#Include Async.ahk

class Promise {
  /**
   * 
   * @param {Promise.Executory} Executory 
   */
  __New(Executory) {
    Resolve(Data) {
      return this
    }
    Reject(Error) {

    }
    Async(Executory.Bind(Resolve, Reject))
  }
  class Executory extends Func {

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
  Catch(ErrorCallback) {

  }
  Finally() {
    return this
  }
  static Resolve(Data) {

  }
  static Reject(Error) {
    
  }
  static All(Promises*) {

  }
  static Any(Promises*) {

  }
  static Race(Promises*) {

  }
}