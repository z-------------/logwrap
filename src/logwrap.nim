import osproc
import os
import streams
import times

var ret = QuitSuccess

proc main() =
  doAssert paramCount() > 0

  let
    params = commandLineParams()
    cmd = params[0]
    args = params[1..params.high]
    process = startProcess(cmd,
      args = args,
      options = {poUsePath, poStdErrToStdOut}
    )
    outStream = process.outputStream

  while not outStream.atEnd:
    let
      preStr = now().format("[yyyy-MM-dd HH:mm:ss'.'fff] ")
      postStr = ""
    echo preStr, outStream.readLine(), postStr

  ret = process.waitForExit()
  process.close()

when isMainModule:
  main()
  quit(ret)
