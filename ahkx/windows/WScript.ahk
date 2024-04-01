/************************************************************************
 * @description 
 * @file WScript.ahk
 * @author Jackson
 * @date 2023/09/24
 * @version 0.0.1
 ***********************************************************************/

#Include <ahkx\test\TestTool>

class WScript {

  /** @type {String}  返回主机可执行文件（CScript.exe 或 WScript.exe）的完全限定路径 */
  FullName := unset

  /** @type {String} WScript 对象（主机可执行文件）的名称 */
  Name := unset

  /**
   * @param Command 执行的命令
   * @returns {WScript.Exec}
   */
  Exec(Command) {
  }
  /**
   * 
   * @param Command 
   * @param {'Failed'|'Finished'} WindowInitStyle 
   * @param {Boolean} Wait 
   */
  Run(Command, WindowInitStyle?, Wait := false) {
    this.Run(, '')
  }
  Echo(Command) {
  }
  class Exec {
    /** @type {'WshFailed'=2|'WshFinished'=1|'WshRunning'=0} */
    Status := unset
    ExitCode := unset
    ProcessID := unset

    /** @type {WScript.Exec.StdIn} */
    StdIn := unset
    /** @type {WScript.Exec.StdOut} */
    StdOut := unset
    /** @type {WScript.Exec.StdErr} */
    StdErr := unset
    Terminate() {
    }
    class Std {
      Close() {
      }
    }
    class StdIn extends WScript.Exec.Std {
      Write(String) {
      }
    }
    class StdOut extends WScript.Exec.Std {
      /** @returns {String} */
      Read() {
      }
      /** @returns {String} */
      ReadAll() {
      }
    }
  }

  /**
   * @returns {WScript}
   */
  static Call() {
    return ComObject('WScript.Shell')
  }
}
