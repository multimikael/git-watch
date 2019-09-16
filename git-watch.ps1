[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null

$appid = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"
$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appid)

$icon = "C:\Program Files\Git\mingw64\share\git\git-for-windows.ico"

foreach ($repo in get-content "$env:USERPROFILE\.git-watch") {
    Set-Location $repo
    $branch = git rev-parse --abbrev-ref HEAD
    $name = (get-item $pwd).Name
    $remote = git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)"
    
    git fetch
    $log = git log -1 HEAD..$remote --pretty=format:"%s (%an)"

    if ($log.count -gt 0) {
        $xmlString = @"
<toast>
    <visual>
    <binding template="ToastGeneric">
        <text>New commits in $name/$branch</text>
        <text>$log</text>
        <image src="$icon" placement="appLogoOverride" hint-crop="circle" />
    </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Default" />
</toast>
"@
        Write-Output $xmlString
        $xml = [Windows.Data.Xml.Dom.XmlDocument]::new()
        $xml.LoadXml($xmlString)
        $toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
        $notifier.Show($toast)
    }
}
