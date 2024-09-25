@echo off & setlocal DisableDelayedExpansion

rem Get file address
set "file_address=%~1"

rem Replace backslashes (\) with forward slashes (/) in file path
set "file_path=%file_address:\=/%"

rem Extract directory path from file path
for %%I in ("%file_path%") do set "dir_path=%%~dpI"

rem Replace backslashes (\) with forward slashes (/) in directory path
set "dir_path=%dir_path:\=/%"

rem Remove trailing backslash from directory path
if "%dir_path:~-1%"=="\" set "dir_path=%dir_path:~0,-1%"

rem Check the first character of the file path
set "first_char=%file_path:~0,1%"

rem Filter for which Drive type the file path is
if "%first_char%"=="C" goto ProcessWindowsFilePath
if "%first_char%"=="D" goto ProcessWindowsFilePath
if "%first_char%"=="E" goto ProcessWindowsFilePath
if "%first_char%"=="F" goto ProcessWindowsFilePath
if "%first_char%"=="G" goto ProcessWindowsFilePath
else if "%first_char%"=="\" (
	if "%file_path:~16,6%"=="Ubuntu" goto ProcessUbuntuFilePath
	if "%file_path:~16,14%"=="docker-desktop" goto ProcessDockerDesktopFilePath
	if "%file_path:~16,19%"=="docker-desktop-data" goto ProcessDockerDesktopDataFilePath
  goto ProcessYourDistroFilePath
)
goto End

rem Clean up file path
:ProcessWindowsFilePath
rem Remove first 2 characters (assuming it's the drive letter and backslash)
set "real_file_path=%file_path:~2%"
set "real_dir_path=%dir_path:~2%"
rem Prepend /mnt/c/ to the paths to properly reference the Windows drive in WSL
set "ready_file_path=/mnt/c%real_file_path%"
set "ready_dir_path=/mnt/c%real_dir_path%"
goto End

:ProcessUbuntuFilePath
rem Remove the first 22 characters to get the Ubuntu path
set "real_file_path=%file_path:~23%"
set "real_dir_path=%dir_path:~23%"
rem Prepend / to the paths to properly reference the Ubuntu drive in Linux
set "ready_file_path=/%real_file_path%"
set "ready_dir_path=/%real_dir_path%"
goto End

:ProcessDockerDesktopFilePath
rem Remove the first 30 characters to get the docker-desktop path
set "real_file_path=/%file_path:~31%"
set "real_dir_path=/%dir_path:~31%"
rem Prepend / to the paths to properly reference the docker-desktop drive in Linux
set "ready_file_path=/%real_file_path%"
set "ready_dir_path=/%real_dir_path%"
goto End

:ProcessDockerDesktopDataFilePath
rem Remove the first 35 characters to get the docker-desktop-data path
set "real_file_path=/%file_path:~36%"
set "real_dir_path=/%dir_path:~36%"
rem Prepend / to the paths to properly reference the docker-desktop-data drive in Linux
set "ready_file_path=/%real_file_path%"
set "ready_dir_path=/%real_dir_path%"
goto End

rem Your Distro Config Here
:ProcessYourDistroFilePath
rem Here we want to remove the first characters of the file path as they are set as the Windows file path. 
rem To do this were gonna be removing the first 16 characters which is `\\wsl.localhost`. 
rem Then we need to remove the amount of character of your distro file path name. 
rem Eg. If you installed debian we need to remove an additional 6 characters.
rem So we need to remove a total of 16+6+1 = 22 characters. (The plus 1 is the extra /)
rem So in the following you need to edit the number in`%file_path:~00% underneath, in order to suit your distro file path.` 
set "real_file_path=/%file_path:~00%"
set "real_dir_path=/%dir_path:~00%"
rem Then we want to Prepend / to the paths to reference them properly. (no edits needed here)
set "ready_file_path=/%real_file_path%"
set "ready_dir_path=/%real_dir_path%"

:End

rem Set command to open a tmux session that redirects to file directory and opens the file in nvim
rem If you dont use tmux uncomment this line
rem "command=source ~/.zshrc; cd \"%ready_dir_path%\"; $(which nvim) \"%ready_file_path%\""

rem If you use tmux, keep this line uncommented
set "command=source ~/.zshrc; $(which tmux) new 'cd \"%ready_dir_path%\"; $(which nvim) \"%ready_file_path%\"'"

rem Copy file & directory path into clipboard
rem echo "%first_char%" | clip
rem echo "%ready_file_path%" | clip
rem echo "%ready_dir_path%" | clip
rem echo "%command%" | clip
echo "%ready_file_path%" | clip

rem Launch ubuntu.exe with cmd.exe commands
rem Edit `ubuntu.exe` to your distro command. (Eg. debian.exe, etc.)
echo "Run Ubuntu"
start "" ubuntu.exe run %command%
