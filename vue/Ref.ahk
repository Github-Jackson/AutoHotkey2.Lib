/************************************************************************
 * @description 
 * @file Ref.ahk
 * @author Jackson
 * @date 2023/10/19
 * @version 0.0.1
 ***********************************************************************/
#Include <vue\Vue>

/**
 * 构建响应式对象, 通过.Value访问和设置响应式
 * @param {Any} Value 构建响应式的原始值
 * @returns {Vue.Ref} 响应式值对象
 */
Ref(Value := ''){
  if(Value is Vue.Object){
    return Value
  }
  return Vue.Ref(Value)
}