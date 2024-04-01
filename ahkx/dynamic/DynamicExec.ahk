/************************************************************************
 * @description 
 * @file DynamicExec.ahk
 * @author Jackson
 * @date 2023/09/24
 * @version 0.0.1
 ***********************************************************************/
#Include <ahkx\windows\WScript>

/** 使用WScript.Shell.Exec Autohotkey * 实现的动态执行类 */
class DynamicExec {
  /** @type {WScript.Exec} */
  _Executor := unset
  __New() {
    static WSH := WScript()
    static EXECUTOR := A_AhkPath
    this._Executor := WSH.Exec(A_AhkPath ' *')
  }

  Exec(Script) {
    this._Executor.StdIn.Write(Script)
    return this._Executor.StdIn.Close()
  }
  ExecSync(Script) {
    this._Executor.StdIn.Write('FileAppend(' Script ',"*")')
    this._Executor.StdIn.Close()
    return this._Executor.StdOut.ReadAll()
  }
  Call(Script){
    return this.Exec(Script)
  }
}