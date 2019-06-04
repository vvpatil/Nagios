################################################################################
## This plugin pulls all files in each specified directory, and checks their  ##
## created time against the current time. If the maximum age of any file is   ##
## exceeded, a critical message is returned as appropriate.                   ##
## Plugin by Vishal Vilas Patil  - vicky_vishalpatil@hotmail.com		      ##
################################################################################

# Change the path & adjust the days/hours/mins as per your requirement
$fullPath = "DIRECTORY_PATH"
$numdays = 0
$numhours = 0
$nummins = 45

function ShowOldFiles($path, $days, $hours, $mins)
{
    $files = @(get-childitem $path -include *.* -recurse | where {($_.LastWriteTime -lt (Get-Date).AddDays(-$days).AddHours(-$hours).AddMinutes(-$mins)) -and ($_.psIsContainer -eq $false)})
    if ($files -ne $NULL)
    {
        for ($idx = 0; $idx -lt $files.Length; $idx++)
        {
            $file = $files[$idx]
            write-host ("Old: " + $file.Name);exit 2
        }
    }
else {
write-host ("No files older then 45mins"); exit 0
}
}

ShowOldFiles $fullPath $numdays $numhours $nummins
