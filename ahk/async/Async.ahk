/************************************************************************
 * @description 
 * @file Async.ahk
 * @author Jackson
 * @date 2023/09/23
 * @version 0.0.0
 ***********************************************************************/

/** 设置经过一定延迟{Delay}(毫秒)时间后异步执行目标函数
 * @param {()=>Void} Action 要执行的函数对象
 * @param {Number} Delay 执行前的延迟(毫秒)
 * @param {Number} Priority 异步执行的优先级-2147483648~2147483647
 * @returns {()=>Void} {Action} 定时器标识, 用于SetTimer停止定时器或更新定时器延迟,优先级
 */
Async(Action, Delay := 0, Priority := -1) {
  SetTimer(Action, Delay == 0 ? -1 : -Abs(Delay), Priority)
  return Action
}