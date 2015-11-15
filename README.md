# Xcode Smart Exception Breakpoint

## How to make LLDB Debugger to ignore expected exceptions

[Shared Exception Breakpoint Debugger Command](SmartExceptionBreakpoint.xcworkspace/xcshareddata/xcdebugger/Breakpoints_v2.xcbkptlist#L18)

Add this Debugger Command to Exception Breakpoint:
```
script lldb.process.Continue() if lldb.frame.EvaluateExpression("debuggerContinueOnExceptions").GetValueAsUnsigned() else None
```

Set global variable
```
BOOL debuggerContinueOnExceptions = NO;
```

Change it's value to YES before executing a block where exception is expected

And change it back to NO after the same block.

Read more details on blog: http://paulz.github.io/ios/tdd/unit/objc/2015/11/14/testing-code-that-catches-exceptions.html
