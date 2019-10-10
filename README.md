# Git-watch
## Bash script for Linux
The `git-watch` file contains a Bash script which uses libnotify (notify-send) to send desktop notifications.

### Systemd service and timer
There is a systemd service unit file `git-watch.service`. This is needed for the systemd timer `git-watch.timer`. These can be placed to be installed as user units in [a few directories](https://wiki.archlinux.org/index.php/systemd/User#How_it_works), eg. `~/.config/systemd/user/`. This requires the `git-watch` script to be placed in the [systemd-aware PATH](https://wiki.archlinux.org/index.php/systemd/User#Environment_variables), eg. `/usr/local/bin/`. 

The timer runs on boot up and every 30 minutes, and be enabled with systemctl:

``` sh
systemctl --user enable git-watch.timer
```

## PowerShell script for Windows
The `git-watch.ps1` file contains a PowerShell script. 

The script requires a `.git-watch` file located at the USERPROFILE directory, which should be `C:\Users\{user}` unless changed. 

The script can be ran manually from a PowerShell or by right-clicking the file and *Run with PowerShell* as it requires no arguments.

### Schedule git-watch with Task Scheduler
Git-watch can be scheduled to be ran every so often using Windows' built-in [Task Scheduler](https://devblogs.microsoft.com/scripting/weekend-scripter-use-the-windows-task-scheduler-to-run-a-windows-powershell-script/). And can even be set to run [every minute](https://lazywinadmin.com/2012/03/run-this-task-every-minute.html). When running a PowerShell using the Task Scheduler, the terminal window will still pop up. This can be hidden by setting the task to *Run whether user is logged on or not* in the Properties of the task. This will result in the task running the background.

## Troubleshooting

**Not allowed to execute PowerShell scripts**

You need to set your [execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6) to *RemoteSigned* or higher to be able to execute PowerShell scripts. 

**No icon on notification**

On Windows, the notification uses an icon located at `C:\Program
Files\Git\mingw64\share\git\git-for-windows.ico`, which should be available if
have [Git](https://git-scm.com/) installed. Alternatively you can change icon by
changing the `$icon = "C:\some\icon"` line in the `git-watch.ps1` file.

On Linux, the notification icon is set to `software-update-available` which should be in your icon theme. This can be changed to [any icon available](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html) by the icon argument of `notify-send`.  
