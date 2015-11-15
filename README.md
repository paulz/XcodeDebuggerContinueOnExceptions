# Xcode Smart Exception Breakpoint

## How to make LLDB Debugger to ignore expected exceptions

1. Add this Debugger Command to Exception Breakpoint:
 * ```script lldb.process.Continue() if lldb.frame.EvaluateExpression("debuggerContinueOnExceptions").GetValueAsUnsigned() else None```
2. Set global variable
 * ```BOOL debuggerContinueOnExceptions = NO;```
3. Change ```debuggerContinueOnExceptions = YES;``` before executing a block where exception is expected
4. And change it back after that block ```debuggerContinueOnExceptions = NO;```.

Read more details on blog: http://paulz.github.io/ios/tdd/unit/objc/2015/11/14/testing-code-that-catches-exceptions.html

Open included example project in Xcode: [SmartExceptionBreakpoint.xcworkspace](SmartExceptionBreakpoint.xcworkspace)
and run tests: Command-U
