/************************************************************************
 * @description 
 * @file Arrays.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

/** 一些数组方法 */
class Arrays extends Array{

  /** 对(Arr)数组元素进行(插入)排序
   * @param {Array} Arr 排序的目标数组
   * @returns {Array} 排序后的数组
   */
  static Sort(Arr) {
    len := Arr.Length
    loop len - 1 {
      val := Arr[A_Index + 1]
      i := A_Index
      while (i >= 1 && Arr[i] > val) {
        Arr[i + 1] := Arr[i]
        Arr[i] := val
        i -= 1
      }
    }
    return Arr
  }
}