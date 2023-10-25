/************************************************************************
 * @description 
 * @file UseToolTip.ahk
 * @author Jackson
 * @date 2023/10/19
 * @version 0.0.0
 ***********************************************************************/
#Include <vue\Vue>
#Include <vue\Ref>

/**
 * 
 * @param {Vue.Ref|Any} RefText 
 */
UseToolTip(Text){
  Text := Ref(Text)
  Vue((){
    ToolTip(Text.Value)
  })
  return Text
}