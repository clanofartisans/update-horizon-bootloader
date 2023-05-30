$config = $env:APPDATA + "\HorizonXI-Launcher\storage.json"

$config = Get-Content $config -Raw

$config = $config | ConvertFrom-Json

$bootloader = $config.paths.InstallPath.path + "\bootloader\horizon-loader.exe"

$hash = Get-FileHash $bootloader

if ($hash.Hash -ne "539546BCA1EF9CBAC53160B179A95C76E6DE05306F8CEDFE1DE68A4E6B5CB153") {
    Write-Output "Bootloader is outdated..."
	Write-Output "Downloading new bootloader from Discord..."
	Invoke-WebRequest -URI "https://cdn.discordapp.com/attachments/1048426076608680006/1100203516284387369/horizon-loader.exe" -OutFile "horizon-loader.exe"
	Write-Output "Download completed..."
	Write-Output "Copying new bootloader..."
	Copy-Item -Path ".\horizon-loader.exe" -Destination $bootloader -Force
	Write-Output "Verifying update..."
	$hash = Get-FileHash $bootloader
	if ($hash.Hash -eq "539546BCA1EF9CBAC53160B179A95C76E6DE05306F8CEDFE1DE68A4E6B5CB153") {
		Write-Output "Bootloader was updated successfully!"
	} else {
		Write-Output "Bootloader wasn't updated... Something has gone wrong..."
	}
} else {
    Write-Output "Bootloader is already up-to-date!"
}
