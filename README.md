# l4d2-versus-bypass

This script automates the entire process of bypassing the versus addon restriction based off of [this](https://www.youtube.com/watch?v=jWyQyRTowu4 "this") video

# Usage
Replace `C:\Program Files (x86)\Steam\steamapps\common\Left 4 Dead 2\left4dead2\gameinfo.txt` with the `gameinfo.txt` in this repository.
Run `bypass.ps1` and let the script do its thing. Most errors related to moving files can be safely ignored.

# Notes
You may need to set the Powershell execution policy to `Unrestricted`, if you\'ve never tried to run a Powershell script before.
Simply open up a Powershell terminal, and enter `Set-ExecutionPolicy Unrestricted`.

You may also need to install `Left 4 Dead 2 Authoring Tools` from Steam, or modify the VPK path to point to a `vpk.exe` file.
