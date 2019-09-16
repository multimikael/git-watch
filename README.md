# Git-watch
## PowerShell script for Windows
The `git-watch.ps1` file contains a PowerShell script. 

The script requires a `.git-watch` file located at the USERPROFILE directory, which should be `C:\Users\{user}` unless changed. 

The script can be ran manually from a PowerShell or by right-clicking the file and *Run with PowerShell* as it requires no arguments.

### Schedule git-watch with Task Scheduler
Git-watch can be scheduled to be ran every so often using Windows' built-in [Task Scheduler](https://devblogs.microsoft.com/scripting/weekend-scripter-use-the-windows-task-scheduler-to-run-a-windows-powershell-script/). And can even be set to run [every minute](https://lazywinadmin.com/2012/03/run-this-task-every-minute.html). When running a PowerShell using the Task Scheduler, the terminal window will still pop up. This can be hidden by setting the task to *Run whether user is logged on or not* in the Properties of the task. This will result in the task running the background.

### Troubleshooting

****

You need to set your [execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6) to *RemoteSigned* or higher to be able to execute PowerShell scripts. 

**No icon on notification**

The notification uses an icon located at `C:\Program Files\Git\mingw64\share\git\git-for-windows.ico`, which should be available if have [Git](https://git-scm.com/) installed. Alternatively you can change icon by changing the `$icon = "C:\some\icon"` line in the `git-watch.ps1` file.
