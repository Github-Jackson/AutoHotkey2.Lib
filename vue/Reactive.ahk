/************************************************************************
 * @description 
 * @file Reactive.ahk
 * @author Jackson
 * @date 2023/10/19
 * @version 0.0.1
 ***********************************************************************/
#Include <vue\Vue>
#Include <ahk\type\Point>

/** 构建响应式对象
 * @param {Any} Target 需要构建响应式的对象
 */
Reactive(Target) {
  if (Target is Vue.Object) {
    return Target
  }
  return Vue.Reactive(Target)
}