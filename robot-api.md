### Robot Api

- Robot framework has an api which provides functions to run them from python.
- Documentation is available at [Robot Documentation](https://robot-framework.readthedocs.io)

Main API entry points are documented here, but the lower level implementation details are not always that well documented.
Robot Framework source code available at: [Source Code](https://github.com/robotframework/robotframework). #Source-code

### Entry points

Command line entry points are implemented as Python modules and they also provide programmatic APIs. Following entry points exist:

- `robot.run` entry point for executing tests.
- `robot.rebot` entry point for post-processing outputs (Rebot).
- `robot.libdoc` entry point for Libdoc tool.
- `robot.testdoc` entry point for Testdoc tool.

> User guide information is available at [Robot Framework User Guide](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html) #user-guide

### Creating start-up scripts

Test cases are often executed automatically by a continuous integration system or some other mechanism. In such cases, there is a need to have a script for starting the test execution, and possibly also for post-processing outputs somehow. Similar scripts are also useful when running tests manually, especially if a large number of command line options are needed or setting up the test environment is complicated.

In UNIX-like environments, shell scripts provide a simple but powerful mechanism for creating custom start-up scripts. Windows batch files can also be used, but they are more limited and often also more complicated. A platform-independent alternative is using Python or some other high-level programming language. Regardless of the language, it is recommended that long option names are used, because they are easier to understand than the short names.

**Shell script example**

In this example, the same web tests in the login directory are executed with different browsers and the results combined afterwards using Rebot. The script also accepts command line options itself and simply forwards them to the robot command using the handy $\* variable:

```shell
#!/bin/bash
robot --name Firefox --variable BROWSER:Firefox --output out/fx.xml --log none --report none $* login
robot --name IE --variable BROWSER:IE --output out/ie.xml --log none --report none  $* login
rebot --name Login --outputdir out --output login.xml out/fx.xml out/ie.xml
```

**Batch file example**

Implementing the above shell script example using batch files is not very complicated either. Notice that arguments to batch files can be forwarded to executed commands using %\*:

```commandline
@echo off
robot --name Firefox --variable BROWSER:Firefox --output out\fx.xml --log none --report none %* login
robot --name IE --variable BROWSER:IE --log none --output out\ie.xml --report none %* login
rebot --name Login --outputdir out --output login.xml out\fx.xml out\ie.xml
```

> **Note**
> Prior to Robot Framework 3.1 robot and rebot commands were implemented as batch files on Windows and using them in another batch file required prefixing the whole command with call.

**Python example**

When start-up scripts gets more complicated, implementing them using shell scripts or batch files is not that convenient. This is especially true if both variants are needed and same logic needs to be implemented twice. In such situations it is often better to switch to Python. It is possible to execute Robot Framework from Python using the subprocess module, but often using Robot Framework's own programmatic API is more convenient. The easiest APIs to use are robot.run_cli and robot.rebot_cli that accept same command line arguments than the robot and rebot commands.

The following example implements the same logic as the earlier shell script and batch file examples. In Python arguments to the script itself are available in sys.argv:

```python
#!/usr/bin/env python
import sys
from robot import run_cli, rebot_cli

common = ['--log', 'none', '--report', 'none'] + sys.argv[1:] + ['login']
run_cli(['--name', 'Firefox', '--variable', 'BROWSER:Firefox', '--output', 'out/fx.xml'] + common, exit=False)
run_cli(['--name', 'IE', '--variable', 'BROWSER:IE', '--output', 'out/ie.xml'] + common, exit=False)
rebot_cli(['--name', 'Login', '--outputdir', 'out', 'out/fx.xml', 'out/ie.xml'])
```

> **Note**
> exit=False is needed because by default run_cli exits to system with the correct return code. rebot_cli does that too, but in the above example that is fine.

### Programmatically calling the API

- We need to use the `run api`
- We need to pass the test path and the options which we generally pass through command line

```python
from robot import run

ROBOT_AUTO_KEYWORDS = True
auto_keywords = True
test_path = "c:/temp"
options = {
    "outputdir": "path/where/output/needed",
    "include": [],
    "splitlog": True,
    "log": "none",
    "report": "none"
}

result = run(test_path, **options)
if result == 0:
    print("Test Executed Successfully")
else:
    print("Execution Failed")
```

### Return codes

- Runner scripts communicate the overall test execution status to the system running them using return codes.
- When the execution starts successfully and no tests fail, the return code is zero.
- All possible return codes are explained in the table below.

**Possible return codes**

| RC    | Explanation                                |
| ----- | ------------------------------------------ |
| 0     | All tests passed.                          |
| 1-249 | Returned number of tests failed.           |
| 250   | 250 or more failures.                      |
| 251   | Help or version information printed.       |
| 252   | Invalid test data or command line options. |
| 253   | Test execution stopped by user.            |
| 255   | Unexpected internal error.                 |

- Return codes should always be easily available after the execution, which makes it easy to automatically determine the overall execution status.
- For example,
  - in bash shell the return code is in special variable `$?`
  - in Windows it is in `%ERRORLEVEL%` variable.

> If you use some external tool for running tests, consult its documentation for how to get the return code.

- The return code can be set to 0 even if there are failures using the --NoStatusRC command line option.
- This might be useful, for example, in continuous integration servers where post-processing of results is needed before the overall status of test execution can be determined.

> **Note**
> Same return codes are also used with Rebot.

### Errors and warnings during execution

- During the test execution there can be unexpected problems like failing to import a library or a resource file or a keyword being deprecated.
- Depending on the severity such problems are categorized as errors or warnings and they are written into the console (using the standard error stream), shown on a separate Test Execution Errors section in log files, and also written into Robot Framework's own system log.
- Normally these errors and warnings are generated by Robot Framework itself, but libraries can also log errors and warnings.
- Example below illustrates how errors and warnings look like in the log file.

```log
20090322 19:58:42.528 ERROR Error in file '/home/robot/tests.robot' in table 'Setting' in element on row 2: Resource file 'resource.robot' does not exist
20090322 19:58:43.931 WARN Keyword 'SomeLibrary.Example Keyword' is deprecated. Use keyword `Other Keyword`
```

### Listener
- Robot Framework has a listener interface that can be used to receive notifications about test execution.
- Example usages include external test monitors, sending a mail message when a test fails, and communicating with other systems. 
- Listener API version 3 also makes it possible to modify tests and results during the test execution.
- There are 2 versions of listener api.

**Example**
```python
import os.path
import tempfile


class PythonListener:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, filename='listen.txt'):
        outpath = os.path.join(tempfile.gettempdir(), filename)
        self.outfile = open(outpath, 'w')

    def start_suite(self, name, attrs):
        self.outfile.write("%s '%s'\n" % (name, attrs['doc']))

    def start_test(self, name, attrs):
        tags = ' '.join(attrs['tags'])
        self.outfile.write("- %s '%s' [ %s ] :: " % (name, attrs['doc'], tags))

    def end_test(self, name, attrs):
        if attrs['status'] == 'PASS':
            self.outfile.write('PASS\n')
        else:
            self.outfile.write('FAIL: %s\n' % attrs['message'])

    def end_suite(self, name, attrs):
         self.outfile.write('%s\n%s\n' % (attrs['status'], attrs['message']))

    def close(self):
         self.outfile.close()
```

> File name and class name should be same for the listener to be picked up as, listener checks for a library.