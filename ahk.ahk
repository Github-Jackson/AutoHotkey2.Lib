/************************************************************************
 * @description 
 * @file ahk.ahk
 * @author Jackson
 * @date 2023/09/26
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\collection\Arrays>

ahk.Setup()
/** ahk的基础扩展, 包括一些内置类, 内置方法的扩展 */
class ahk {
  class Setup {
    /** @type {()=>Void} Array */
    static Array := unset
    static Call() {
      for (key, value in ahk.Setup.OwnProps()) {
        if (key != 'Prototype') {
          value()
        }
      }
    }
  }
  /** Array 扩展类, 为Array附加方法
   * (用于@type {ahk.Array} 语法提示)
   * @extends {Array}
   */
  class Array extends Array {
    static __New() {
      ahk.Setup.Array := () {
        Array.Prototype.Call := ahk.Array.Prototype.Call
        Array.Prototype.DefineProp('__Call', {
          Call: (this, Name, Params) {
            method := ahk.Array.Prototype.GetMethod(Name)
            if (method) {
              Array.Prototype.DefineProp(Name, {
                Call: method
              })
              return method(this, Params*)
            }
          }
        })
      }
    }

    /** 将数组中每一项视为(Function)调用执行, 传递{Params*}
     * 需自行处理函数项调用时的参数个数匹配
     * @param {Array} Params Array<Any>
     * @returns {ahk.Array} this
     */
    Call(Params*){
      for (index,item in this) {
        item(Params*)
      }
      return this
    }

    /** 判断数组的每一项是否都满足{Predicate(Item,Index?)=>Boolean}条件函数. 并返回结果
     * @param {(Item,Index?)=>Boolean} Predicate 判断函数: 返回True表示满足
     * @returns {Boolean} 是否数组的每一项都满足条件{Predicate(Item,Index?)=>Boolean}
     */
    Every(Predicate) {
      result := true
      if (Predicate.MaxParams == 1) {
        for (index, item in this) {
          result |= Predicate(item)
        }
      }

    }
    /**
     * 
     */
    Each(FunctionName) {

    }
    /** 循环数组调用{Call(Item,Index)}
     * @param {(Item,Index?)=>Void} Call 
     * @returns {ahk.Array} this
     */
    Foreach(Call) {
      if (Call.MaxParams == 1) {
        for (index, item in this) {
          Call(item)
        }
      } else {
        for (index, item in this) {
          Call(item, index)
        }
      }
      return this
    }

    /** 返回通过{Predicate(Item,Index?)=>Any|unset}函数筛选后的项数组
     * @param {(Item,Index?)=>Any|unset} Predicate 筛选函数: 若跳过该项,返回unset
     * @returns {ahk.Array} 筛选后的数组
     */
    Filter(Predicate) {
      arr := []
      if (Predicate.MaxParams == 1) {
        for (index, item in this) {
          result := Predicate(item) ?? unset
          if (IsSet(result)) {
            arr.Push(result)
          }
        }
      } else {
        for (index, item in this) {
          result := Predicate(item, index) ?? unset
          if (IsSet(result)) {
            arr.Push(result)
          }
        }
      }
      return arr
    }

    /** 将数组元素拼接成字符串
     * @param {String} Separator 每个项之间要添加的分隔符
     * @returns {String} 完成拼接的字符串
     */
    Join(Separator?) {
      result := this[1] ?? '',
        index := 2,
        length := this.Length
      if (IsSet(Separator)) {
        while index <= length {
          result .= Separator . this[index++]
        }
      } else {
        while index <= length {
          result .= this[index++]
        }
      }
      return result
    }
    /** 移除并返回数组的第一个元素
     * @returns {*} 数组被删除的第一个元素
     * @throws {Error} 数组为空抛出{Error("Array is empty.")}
     */
    Shift() {
      if (this.Length > 0) {
        return this.RemoveAt(1)
      }
      Throw(Error('Array is empty.'))
    }
    /** 从数组的头部插入一个或多个元素
     * @param {Array} Values 要插入的元素
     * @returns {ahk.Array} 
     */
    Unshift(Values*) {
      this.InsertAt(1, Values*)
      return this
    }
    /** 对数组进行(插入)降序排序
     * @returns {ahk.Array} this
     */
    Sort() {
      return Arrays.Sort(this)
    }
  }
}