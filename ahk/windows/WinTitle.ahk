/************************************************************************
 * @description 
 * @file WinTitle.ahk
 * @author Jackson
 * @date 2023/09/20
 * @version 0.0.1
 ***********************************************************************/

/** 用于构建WinTitle匹配条件的类 */
class WinTitle {
  /** 构建WinTitle匹配条件
   * @param {'A'|String|Number} Title 窗口标题或窗口的唯一ID(HWND);
   * 或使用'A'并省略其他参数指向当前活动窗口
   * @param {String} Exe 进程名称或执行程序的完整路径
   * @param {Number} HWND 窗口ID
   * @param {Number} PID 进程ID
   * @param {String} Class 窗口类名
   * @returns {String} WinTitle字符串
   */
  static Call(Title := '', Exe?, HWND?, PID?, Class?) {
    if (IsSet(Exe)) {
      Title .= ' ' this.Exe(Exe)
    }
    if (IsSet(HWND)) {
      Title .= ' ' this.ID(HWND)
    }
    if (IsSet(PID)) {
      Title .= ' ' this.PID(PID)
    }
    if (IsSet(Class)) {
      Title .= ' ' this.Class(Class)
    }
    return Title
  }
  /** 构建WinTitle(ahk_id {Value})
   * @param {Number} Value 窗口ID(HWND)
   * @returns {String} ahk_id {Value}
   */
  static ID(Value) {
    static AHK_ID := 'ahk_id '
    return AHK_ID . Value
  }
  /** 构建WinTitle(ahk_pid {Value})
   * @param {Number} Value 进程ID(PID)
   * @returns {String} ahk_pid {Value}
   */
  static PID(Value) {
    static AHK_PID := 'ahk_pid '
    return AHK_PID . Value
  }
  /** 构建WinTitle(ahk_exe {Value})
   * @param {String} Value 进程名或执行程序的完整路径
   * @returns {String} ahk_exe {Value}
   */
  static Exe(Value) {
    static AHK_EXE := 'ahk_exe '
    return AHK_EXE . Value
  }
  /** 构建WinTitle(ahk_class {Value})
   * @param {String} Value 窗口类
   * @returns {String} ahk_class {Value}
   */
  static Class(Value) {
    static AHK_CLASS := 'ahk_class '
    return AHK_CLASS . Value
  }

  /** 创建WinTitle构建器
   * @param {'A'|String|Number} Title 窗口标题或窗口的唯一ID(HWND);
   * 或使用'A'并省略其他参数指向当前活动窗口
   * @param {String} Exe 进程名称或执行程序的完整路径
   * @param {Number} HWND 窗口ID
   * @param {Number} PID 进程ID
   * @param {String} Class 窗口类名
   * @returns {WinTitle.WinTitleBuilder}
   */
  static Builder(Title?) {
    return WinTitle.WinTitleBuilder(Title?)
  }
  class WinTitleBuilder {
    /** 创建WinTitle构建器
     * @param {'A'|String|Number} Title 窗口标题或窗口的唯一ID(HWND);
     * 或使用'A'并省略其他参数指向当前活动窗口
     * @param {String} Exe 进程名称或执行程序的完整路径
     * @param {Number} HWND 窗口ID
     * @param {Number} PID 进程ID
     * @param {String} Class 窗口类名
     */
    __New(Title := '') {
      this.DefineProp('__New', {
        Value: {
          Title : Title
        }
      })
    }
    /** 设置Title
     * @param {'A'|String|Number} Title 窗口标题或窗口的唯一ID(HWND);
     * 或使用'A'并省略其他参数指向当前活动窗口
     * @param {String} Exe 进程名称或执行程序的完整路径
     * @param {Number} HWND 窗口ID
     * @param {Number} PID 进程ID
     * @param {String} Class 窗口类名
     * @returns {WinTitle.WinTitleBuilder} this
     */
    Title(Title := 'A', Exe?, HWND?, PID?, Class?) {
      if (IsSet(Exe)) {
        this.__New.Exe := Exe
      }
      if (IsSet(HWND)) {
        this.__New.ID := HWND
      }
      if (IsSet(PID)) {
        this.__New.PID := PID
      }
      if (IsSet(Class)) {
        this.__New.Class := Class
      }
      return this
    }
    /** 设置ahk_id
     * @param {Number} Value 窗口ID(HWND)
     * @returns {WinTitle.WinTitleBuilder} this
     */
    ID(Value) {
      this.__New.ID := Value
      return this
    }
    /** 设置ahk_pid
     * @param {Number} Value 进程ID(PID)
     * @returns {WinTitle.WinTitleBuilder} this
     */
    PID(Value) {
      this.__New.PID := Value
      return this
    }
    /** 设置ahk_exe
     * @param {String} Value 进程名称或执行程序的完整路径
     * @returns {WinTitle.WinTitleBuilder} this
     */
    Exe(Value) {
      this.__New.Exe := Value
      return this
    }
    /** 设置ahk_class
     * @param {String} Value 窗口类
     * @returns {WinTitle.WinTitleBuilder} this
     */
    Class(Value) {
      this.__New.Class := Value
      return this
    }
    /** 构建WinTitle匹配条件
     * @returns {String} WinTitle
     */
    Build() {
      result := this.__New.Title ?? ''
      this.__New.Title := unset
      for (prop, val in this.__New.OwnProps()) {
        result .= ' ' WinTitle.%prop%(val)
      }
      return result
    }
  }
}