/************************************************************************
 * @description 
 * @file FileProxy.ahk
 * @author Jackson
 * @date 2023/09/16
 * @version 0.0.1
 ***********************************************************************/

/** 扩展File类 */
class FileProxy {

  /** @prop {String} Filename 文件名 */
  Filename := unset
  /** @prop {String} Flags 访问模式 */
  Flags := unset
  /** @prop {File} File */
  File := unset
  /** New */
  __New() {
  }

  Open(Flags := this.Flags, Encoding := this.Encoding) {
    this.Flags := Flags, this.Encoding := Encoding
    this.File := FileOpen(this.Filename, Flags, Encoding)
    return this
  }
  /**
   * @param {String} Key 
   * @param {Array} Params 
   */
  __Get(Key, Params) {
    if (Params.Length) {
      return this.File.%Key%[Params*]
    }
    return this.File.%Key%
  }
  /**
   * @param {String} Name 
   * @param {Array} Params 
   */
  __Call(Name, Params) {
    return this.File.GetMethod(Name).Call(this.File, Params*)
  }
  /** 打开文件, 从其中读取特定内容和/或将新内容写入其中.
   * @param {String} Filename 文件名
   * @param {'r'|'w'|'a'|'rw'|'h'} Flags `访问模式(互斥的)`
   * r 0x0 读取: 当文件不存在时失败.
   * w 0x1 写入: 创建新文件, 覆盖任意已存在的文件.
   * a 0x2 追加: 如果文件不存在则创建新文件, 否则移动文件指针到文件末尾.
   * rw 0x3 读取/写入: 当文件不存在时创建新文件.
   * h  表示 Filename 是包装在对象中的文件句柄. 忽略共享模式标志, 并且不检查句柄表示的文件或流的字节顺序标记. 当文件对象销毁时, 当文件对象销毁时, 文件句柄 不会 自动关闭并且调用 Close 没有效果. 注意当 Filename 是非搜寻设备(例如管道或通信设备) 的句柄时, 不应该使用 Seek, Pos 和 Length.
   * 
   * `共享模式标志`
   * -rwd 为读取, 写入和/或删除访问进行文件锁定. 可以使用 r, w 和 d 的任意组合. 指定 - 相当于指定 -rwd. 如果完全省略, 默认为共享所有访问.
   * 0x0 如果 Flags 是数值的, 缺少共享模式标志会让文件被锁定.
   * 0x100 共享 读取 访问.
   * 0x200 共享 写入 访问.
   * 0x400 共享 删除 访问.
   * `行结束符(EOL) 选项`
   * `n 0x4 读取时把 `r`n 替换为 `n 而写入时把 `n 替换为 `r`n.
   * `r 0x8 读取时把单独的 `r 替换为 `n.
   * @param {Encoding} Encoding 如果文件没有 UTF-8 或 UTF-16 字节顺序标记, 或者使用了 h(handle) 标志, 读写文件时使用的代码页(带字节顺序标记的文件 AutoHotkey 自动识别, 指定的 Encoding 无效). 如果省略本参数, 则使用 A_FileEncoding 的当前值.
   * @returns {FileProxy.File}
   */
  static Call(Filename, Flags := 'r', Encoding := A_FileEncoding) {
    oFile := FileOpen(Filename, Flags, Encoding)
    /** @type {FileProxy} */
    proxy := {}
    proxy.Base := FileProxy.Prototype
    proxy.__Init()
    proxy.__New()
    proxy.Filename := Filename
    proxy.Flags := Flags
    proxy.File := oFile
    proxy.DefineProp('__Set', {
      Call: (this, Key, Params, Value) {
        return this.File.%Key% := Value
      }
    })
    return proxy
  }
  class File extends File {
    /** @prop {String} Filename 文件名 */
    Filename := unset
    /** @prop {String} Flags 访问模式 */
    Flags := unset

    /** 打开文件, 从其中读取特定内容和/或将新内容写入其中.
     * @param {'r'|'w'|'a'|'rw'|'h'} Flags `访问模式(互斥的)`
     * r 0x0 读取: 当文件不存在时失败.
     * w 0x1 写入: 创建新文件, 覆盖任意已存在的文件.
     * a 0x2 追加: 如果文件不存在则创建新文件, 否则移动文件指针到文件末尾.
     * rw 0x3 读取/写入: 当文件不存在时创建新文件.
     * h  表示 Filename 是包装在对象中的文件句柄. 忽略共享模式标志, 并且不检查句柄表示的文件或流的字节顺序标记. 当文件对象销毁时, 当文件对象销毁时, 文件句柄 不会 自动关闭并且调用 Close 没有效果. 注意当 Filename 是非搜寻设备(例如管道或通信设备) 的句柄时, 不应该使用 Seek, Pos 和 Length.
     * 
     * `共享模式标志`
     * -rwd 为读取, 写入和/或删除访问进行文件锁定. 可以使用 r, w 和 d 的任意组合. 指定 - 相当于指定 -rwd. 如果完全省略, 默认为共享所有访问.
     * 0x0 如果 Flags 是数值的, 缺少共享模式标志会让文件被锁定.
     * 0x100 共享 读取 访问.
     * 0x200 共享 写入 访问.
     * 0x400 共享 删除 访问.
     * `行结束符(EOL) 选项`
     * `n 0x4 读取时把 `r`n 替换为 `n 而写入时把 `n 替换为 `r`n.
     * `r 0x8 读取时把单独的 `r 替换为 `n.
     * @param {Encoding} Encoding 如果文件没有 UTF-8 或 UTF-16 字节顺序标记, 或者使用了 h(handle) 标志, 读写文件时使用的代码页(带字节顺序标记的文件 AutoHotkey 自动识别, 指定的 Encoding 无效). 如果省略本参数, 则使用 A_FileEncoding 的当前值.
     * @returns {FileProxy.File}
     */
    Open(Flags := this.Flags, Encoding := this.Encoding) {

    }
  }
}