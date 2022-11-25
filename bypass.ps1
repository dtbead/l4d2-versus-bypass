$L4D2Path = "C:\Program Files (x86)\Steam\steamapps\common\Left 4 Dead 2"
$VPKPath = "C:\Program Files (x86)\Steam\steamapps\common\Left 4 Dead 2\bin\vpk.exe"


if ((Test-Path "$L4D2Path\left4dead2_mods") -eq $false ) {
    Write-Output "Creating 'left4dead2_mods' directory"
    New-Item -ItemType Directory -Path "$L4D2Path\left4dead2_mods"
	Write-Output "Finished creating 'left4dead2_mods' directory"
}

[regex]::Matches((Get-Content -LiteralPath "$L4D2Path\left4dead2\addonlist.txt"), '"([^"]+)"\s+?"1"') | ForEach-Object {
    [array]$Addons += $_.Groups[1].Value
}
Write-Output "Found $($Addons.Count) enabled addons"

if ((Test-Path "$L4D2Path\left4dead2_mods\pak01_dir") -eq $false ) {
    Write-Output "Creating 'pak01_dir' directory"
    New-Item -ItemType Directory -Path "$L4D2Path\left4dead2_mods\pak01_dir"
	Write-Output "Finished creating 'pak01_dir' directory"

}

$Addons | ForEach-Object {
    Write-Output "Unpacking $_"
    &$VPKPath "$L4D2Path\left4dead2\addons\$_"
}

$Addons | ForEach-Object {
    $AddonFolder = $_.Trim(".vpk")
    Write-Output "Moving $AddonFolder"

    Get-ChildItem -LiteralPath "$L4D2Path\left4dead2\addons\$AddonFolder" | ForEach-Object {
        if ($_.Name -match "addonimage" -or $_.name -match "addoninfo") {
            Remove-Item $_.FullName
            return
        }
        Move-Item -LiteralPath $_.FullName -Destination "$L4D2Path\left4dead2_mods\pak01_dir\" | Out-Null
    }
	Write-Output "Finished moving $AddonFolder"
}

$Addons | ForEach-Object {
    $AddonFolder = $_.Trim(".vpk")
    Remove-Item -Recurse"$L4D2Path\left4dead2\addons\$AddonFolder"
}

Set-Location "$L4D2Path\left4dead2_mods"
&$VPKPath "pak01_dir"

Remove-Item -Recurse .\pak01_dir 

Write-Output "The script has completed"
pause