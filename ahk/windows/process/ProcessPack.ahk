/************************************************************************
 * @description 
 * @file ProcessPack.ahk
 * @author Jackson
 * @date 2023/09/20
 * @version 0.0.1
 ***********************************************************************/

/** Process系列内置函数的包装类 */
class ProcessPack {
  /** @prop {Number|String} Target 目标进程的PID或者Name */
  Target := unset
  /** 实例化进程操作对象
   * @overload (PID)
   * @overload (Name)
   * @param {Number} PID 进程ID
   * @param {String} Name 进程名(不包含路径,不区分大小写);
   * 一个名称可能与多个正在运行的进程匹配, 
   * 因此将仅对第一个进程进行操作.
   * @param {Number|String} Target 进程PID或者进程名(不包含路径,不区分大小写)
   * 一个名称可能与多个正在运行的进程匹配, 
   * 因此将仅对第一个进程进行操作.
   */
  __New(Target) {
    this.Target := Target
  }
  /** @prop {Number} 进程ID */
  ID {
    get => this.Exist()
  }
  /** @prop {Number} 进程ID */
  PID {
    get => this.Exist()
  }
  /** @prop {String} Name 获取进程名(不包含路径)  */
  Name {
    get => this.GetName()
  }
  /** @prop {String} Path 获取进程路径 */
  Path {
    get => this.GetPath()
  }
  GetName() {
    return ProcessGetName(this.Target)
  }
  GetPath() {
    return ProcessGetPath(this.Target)
  }
  /** 获取创建指定进程的进程 ID(PID).
   * @returns {Integer} 创建目标进程的父进程ID(PID);若没有,返回0
   */
  GetParent() {
    return ProcessGetParent(this.Target)
  }
  /** 更改第一个匹配进程的优先级
   * @param {'Low'|'BelowNormal'|'Normal'|'AboveNormal'|'High'|'Realtime'|'L'|'B'|'N'|'A'|'H'|'R'} Level 优先级
   * 请注意, 如果将任何没有设计为实时优先级运行的进程设置为该级别, 则可能会降低系统稳定性.
   * @returns {Number} 返回进程的ID(PID);如果没有找到匹配的进程或无法操作,返回0
   */
  SetPriority(Level) {
    return ProcessSetPriority(Level, this.Target)
  }

  /** 等待目标进程存在
   * @param {Number|Float} Timeout 设置函数等待超时时间(秒)
   * @returns {Number} 如果发现了指定的进程, 该函数返回该进程的进程 ID (PID). 
   * 如果函数超时, 则返回 0.
   */
  Wait(Timeout?) {
    return ProcessWait(this.Target, Timeout?)
  }
  /** 等待目标进程关闭
   * @param {Number|Float} Timeout 设置函数等待超时时间(秒)
   * @returns {Number} 如果目标进程关闭, 则返回0. 若超时,返回匹配的进程PID
   */
  WaitClose(Timeout?) {
    return ProcessWaitClose(this.Target, Timeout?)
  }
  /** 检查指定进程是否存在
   * @returns {Number} 返回指定进程的进程 ID(PID);若没有匹配的进程,返回 0.
   */
  Exist() {
    return ProcessExist(this.Target)
  }
  /** 强制关闭第一个匹配的进程
   * - 强制关闭进程会中断它的工作或导致窗口中未保存的数据丢失.
   * - 因此建议优先使用WinClose关闭进程窗口.
   * @returns {Number} 返回指定进程的PID;没有找到匹配的进程或无法对其操作, 则返回 0.
   */
  Close() {
    return ProcessClose(this.Target)
  }
}