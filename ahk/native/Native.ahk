/************************************************************************
 * @description 
 * @file Native.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.0
 ***********************************************************************/
#Include <ahk\native\NativeCall>
#Include <ahk\native\types\NativePtr>
#Include <ahk\native\types\NativeStr>
#Include <ahk\native\types\NativeStrP>
#Include <ahk\native\types\NativeInt>
#Include <ahk\native\types\NativeUInt>
#Include <ahk\native\types\NativeUIntP>
#Include <ahk\native\types\NativeInt64>
#Include <ahk\native\types\NativeCallback>

/** 封装Native函数调用 */
class Native {

  /** 创建一个线程执行(Callback)
   * @param {Func} Callback 线程启动的入口函数
   * @param {VarRef} ThreadId VarRef<Number> : 线程ID
   * @returns {Number} 线程句柄
   */
  static CreateThread(Callback, &ThreadId?) {
    result := NativeCall('CreateThread',
      NativePtr(0), NativeUInt(0),
      NativeCallback(Callback, 0),
      NativePtr(0), NativeUInt(0),
      lpThreadId := NativeUIntP(0)
    )
    ThreadId := lpThreadId.Value
    return result
  }
  /** 打开现有线程对象
   * @param ThreadId 要打开的线程的标识符(ID)。
   * @returns {Number} Handle 如果函数成功，则返回值是指定线程的打开句柄。
   * 如果函数失败，则返回值为 NULL。 要获得更多的错误信息，请调用 GetLastError。
   */
  static OpenThread(ThreadId) {
    return NativeCall('OpenThread', NativeUInt(0x1FFFFF), NativeInt(0), NativeUInt(ThreadId))
  }

  /** 关闭打开的对象句柄
   * @param {Number} Handle 对象的有效句柄
   * @returns {Boolean} 
   */
  static CloseHandle(Handle) {
    return NativeCall('CloseHandle', NativePtr(Handle))
  }

  /** 创建或打开命名的或未命名的互斥体对象。
   * @param {Boolean} InitialOwner 如果此值为 TRUE 并且调用方创建了互斥体，则调用线程获取互斥对象的初始所有权。 否则，调用线程不会获得互斥体的所有权。 若要确定调用方是否创建了互斥体，请参阅返回值部分。
   * @param {String} Name 互斥对象的名称。 名称限制为 MAX_PATH 个字符。 名称比较区分大小写。
   * 如果 lpName 与现有命名互斥体对象的名称匹配，则此函数请求 MUTEX_ALL_ACCESS 访问权限。 在这种情况下， 将忽略 bInitialOwner 参数，因为创建过程已设置该参数。 如果 lpMutexAttributes 参数不是 NULL，它将确定是否可以继承句柄，但忽略其安全描述符成员。
   * 如果 lpName 为 NULL，则创建互斥体对象时不带名称。
   * 如果 lpName 与现有事件、信号量、可等待计时器、作业或文件映射对象的名称匹配，则函数将失败， GetLastError 函数返回 ERROR_INVALID_HANDLE。 发生这种情况的原因是这些对象共享相同的命名空间。
   * 名称可以具有“Global”或“Local”前缀，以在全局命名空间或会话命名空间中显式创建对象。 名称的其余部分可以包含除反斜杠字符 (\) 以外的任何字符。 有关详细信息，请参阅 内核对象命名空间。 使用终端服务会话实现快速用户切换。 内核对象名称必须遵循终端服务概述的准则，以便应用程序可以支持多个用户。
   * 可以在专用命名空间中创建 对象。 有关详细信息，请参阅 对象命名空间。
   * @returns {Number} Handle 如果函数成功，则返回值是新创建的互斥对象的句柄。
   * 如果函数失败，则返回值为 NULL。 要获得更多的错误信息，请调用 GetLastError。
   * 如果互斥体是命名互斥体，并且对象在调用此函数之前就存在，则返回值是现有对象的句柄， 而 GetLastError 函数返回 ERROR_ALREADY_EXISTS。
   */
  static CreateMutex(InitialOwner := false, Name := '') {
    return NativeCall('CreateMutex', NativePtr(), NativeInt(InitialOwner), NativeStr(Name))
  }
  /** 打开现有的命名互斥对象。
   * @param {String} Name 要打开的互斥体的名称。 名称比较区分大小写。
   * @returns {Number} Handle 互斥对象的句柄 
   */
  static OpenMutex(Name := '') {
    return NativeCall('OpenMutex', NativeUInt(0x1F0001), NativeUInt(0), NativeStr(Name))
  }
  /** 释放指定互斥对象的所有权。
   * @param {Number} Handle 互斥对象的句柄。 CreateMutex 或 OpenMutex 函数返回此句柄。
   * @returns {Number} 如果该函数成功，则返回值为非零值。
   * 如果函数失败，则返回值为零。 要获得更多的错误信息，请调用 GetLastError。
   */
  static ReleaseMutex(Handle) {
    return NativeCall('ReleaseMutex', NativeUInt(Handle))
  }

  /** 等待指定的对象处于信号状态或超时间隔已过。
   * @param {Number} Handle 对象的句柄。 有关可以指定其句柄的对象类型的列表，请参阅以下“备注”部分。
   * 如果在等待仍处于挂起状态时关闭此句柄，则函数的行为未定义。
   * 句柄必须具有 SYNCHRONIZE 访问权限。 有关详细信息，请参阅 标准访问权限。
   * @param {Number} Milliseconds 超时间隔（以毫秒为单位）。
   * 如果指定了非零值，则函数将等待，直到发出对象信号或间隔已过。
   * 如果 dwMilliseconds 为零，则如果未向对象发出信号，
   * 则函数不会进入等待状态;它始终立即返回。 
   * 如果 dwMilliseconds 为 INFINITE，则函数仅在发出对象信号时返回。
   * @returns {Number} DWORD 函数返回的事件
   * WAIT_ABANDONED(0x00000080L): 
   * 指定的 对象是一个互斥对象，在拥有的线程终止之前，拥有互斥对象对象的线程未释放该互斥对象。 互斥对象的所有权授予调用线程，互斥体状态设置为非签名。
   * 如果互斥体正在保护永久性状态信息，则应检查它以确保一致性。
   * 
   * WAIT_OBJECT_0(0x00000000L):
   * 指定对象的状态已发出信号。
   * 
   * WAIT_TIMEOUT(0x00000102L):
   * 超时间隔已过，并且对象的状态未对齐。
   * 
   * WAIT_FAILED((DWORD) 0xFFFFFFFF):
   * 函数失败。 要获得更多的错误信息，请调用 GetLastError。
   */
  static WaitForSingleObject(Handle, Milliseconds := -1) {
    return NativeCall('WaitForSingleObject', NativePtr(Handle), NativeUInt(Milliseconds))
  }
  /** 等待指定的对象处于信号状态、I/O 完成例程或异步过程调用 (APC) 排队到线程，或超时间隔已过。
   * @param {Number} Handle 对象的句柄。 有关可以指定其句柄的对象类型的列表，请参阅以下“备注”部分。
   * 如果在等待仍处于挂起状态时关闭此句柄，则函数的行为未定义。
   * 句柄必须具有 SYNCHRONIZE 访问权限。 有关详细信息，请参阅 标准访问权限。
   * @param {Number} Milliseconds 超时间隔（以毫秒为单位）。
   * 如果指定了非零值，则函数将等待对象收到信号、I/O 完成例程或 APC 已排队或间隔已过。
   * 如果 dwMilliseconds 为零，则如果不满足条件，函数不会进入等待状态; 它始终会立即返回。
   * 如果 dwMilliseconds 为 INFINITE，则仅当向对象发出信号或 I/O 完成例程或 APC 排队时，函数才会返回。
   * @param {Number} Alertable 如果此参数为 TRUE 且线程处于等待状态，则当系统将 I/O 完成例程或 APC 排队，并且线程运行例程或函数时，函数将返回 。 
   * 否则，该函数不会返回，并且不执行完成例程或 APC 函数。
   * @returns {Number} DWORD 函数返回的事件
   * WAIT_ABANDONED(0x00000080L): 
   * 指定的 对象是一个互斥对象，在拥有的线程终止之前，拥有互斥对象对象的线程未释放该互斥对象。 互斥对象的所有权授予调用线程，互斥体状态设置为非签名。
   * 如果互斥体正在保护永久性状态信息，则应检查它以确保一致性。
   * 
   * WAIT_IO_COMPLETION(0x000000C0L): 
   * 等待由一个或多个用户模式 异步过程调用 结束， (APC) 排队到线程。
   * 
   * WAIT_OBJECT_0(0x00000000L):
   * 指定对象的状态已发出信号。
   * 
   * WAIT_TIMEOUT(0x00000102L):
   * 超时间隔已过，并且对象的状态未对齐。
   * 
   * WAIT_FAILED((DWORD) 0xFFFFFFFF):
   * 函数失败。 要获得更多的错误信息，请调用 GetLastError。
   */
  static WaitForSingleObjectEx(Handle, Milliseconds := -1, Alertable := true) {
    return NativeCall('WaitForSingleObjectEx', NativePtr(Handle), NativeUInt(Milliseconds), NativeInt(Alertable))
  }

  /** 暂停当前线程的执行，直到超时间隔结束。
   * @param {Number} Milliseconds 超时间隔(毫秒)
   */
  static Sleep(Milliseconds := 0) {
    return NativeCall('Sleep', NativeInt64(Milliseconds))
  }
  /** 挂起指定(Handle)线程, 线程挂起计数+1
   * @param Handle 要挂起的线程句柄
   * @returns {Number} 如果函数成功，则返回值为线程的上一个挂起计数;
   * 否则为 (DWORD) -1。
   * 若要获取扩展的错误信息，请使用 GetLastError 函数。
   */
  static SuspendThread(Handle) {
    return NativeCall('SuspendThread', NativePtr(Handle))
  }
  /** 递减线程的挂起计数。 当暂停计数减少到零时，线程的执行将恢复。
   * @param Handle 要重启的线程的句柄。
   * 此句柄必须具有THREAD_SUSPEND_RESUME访问权限。
   * 有关详细信息，请参阅 线程安全和访问权限。
   * @returns {Number} 如果函数成功，则返回值是线程的上一个挂起计数。
   * 如果函数失败，则返回值为 (DWORD) -1。 
   * 要获得更多的错误信息，请调用 GetLastError。
   */
  static ResumeThread(Handle) {
    return NativeCall('ResumeThread', NativePtr(Handle))
  }

  /** 检索调用线程的伪句柄。
   * @returns {Number} Handle 返回值是当前线程的伪句柄。 
   */
  static GetCurrentThread() {
    return DllCall('GetCurrentThread')
  }
  /** 检索调用线程的线程标识符。
   * @returns {Number} DWORD 返回值是调用线程的线程标识符。
   */
  static GetCurrentThreadId() {
    return DllCall('GetCurrentThreadId')
  }


  /** 检索调用线程的最后错误代码值。
   * 最后一个错误代码按线程进行维护。
   * 多个线程不会覆盖彼此的最后错误代码。
   * @returns {Number} 返回值是调用线程的最后错误代码。
   * @link https://learn.microsoft.com/zh-cn/windows/win32/debug/system-error-codes
   */
  static GetLastError() {
    return NativeCall('GetLastError')
  }
}