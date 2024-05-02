/************************************************************************
 * @description 
 * @file UseMsgBox.ahk
 * @author 
 * @date 2023/10/19
 * @version 0.0.1
 ***********************************************************************/
#Include <vue\Vue>
#Include <vue\Watch>
#Include <vue\Reactive>

class UseMsgBox {
  /**
   * @overload (Msg)=> UseMsgBox.Msg
   * @param {UseMsgBox.Msg} Msg 
   * @param Text 
   * @param Title 
   * @returns {UseMsgBox.Msg}
   */
  static Call(Text?, Title?) {
    /** @type {UseMsgBox.Msg} */
    Msg := unset
    WatchCallback(*){
      MsgBox(Msg.Text, Msg.Title)
    }
    if(IsSet(Text)){
      Msg := Reactive(Text is Object ? Text : this.Msg(Text?, Title?))
      Vue(WatchCallback)
    }else {
      Msg := Reactive(this.Msg(Text?, Title?))
      Watch(Msg,WatchCallback)
    }
    return Msg
  }
  class Msg {
    Text := unset
    Title := unset
    __New(Text := '', Title?) {
      this.Text := Text
      this.Title := Title ?? "UseMsgBox"
    }
  }
}