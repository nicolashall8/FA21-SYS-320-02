<#

    .Synopsis
        Script to parse the latest NVD dataset feed.

    .Description
        This file will parse a json file and return the results as a CSV file.

    .Example
        .\week15commandlineparams.ps1 -y "2020" -k "cisco" -f "nvd-data.csv"

    .Example
        .\week15commandlineparams.ps1 -year "2020" -keyword "java" -filename "nvd-data.csv"

    .Notes
        Nicolas Hall - December 17, 2021

#>
param(

    [Alias("y")]
    [Parameter (Mandatory=$true)]
    [int]$year,

    [Alias("k")]
    [Parameter (Mandatory=$true)]
    [string]$keyword,

    [Alias("f")]
    [Parameter (Mandatory=$true)]
    [string]$filename

)

cls

# Convert Json File into Powershell Object
$nvd_vulns = (Get-Content -Raw -Path ".\nvdcve-1.1-$year.json" | `
ConvertFrom-Json) | select CVE_Items

# CSV File
# $filename = "C:\Users\nicoh\nvd-data.csv"

# Headers for the CSV file
set-content -Value "`"PublishDate`",`"Description`",`"Impact`",`"CVE`"" $filename

# Array to store the data
$theV = @()

foreach ($vuln in $nvd_vulns.CVE_Items) {

    # Vuln Description
    $descript = $vuln.cve.description.description_data

    # $keyword = "java"
    # Search for the keyword 
    if ($descript -imatch "$keyword") {

        # Published date
        $pubDate = $vuln.publishedDate
        # Description
        $z = $descript | select value
        $description = $z.value

        # Impact
        $y = $vuln.impact
        $impact = $y.baseMetricV2.severity

        # CVE number
        $cve = $vuln.cve.CVE_data_meta.ID

        # Format the CSV file
        $theV += "`"$pubDate`",`"$description`",`"$impact`",`"$cve`"`n"

    }

} # End of the foreach loop

# Convert the array to a string and append to the CSV file
$theV | Add-Content -Path $filename
