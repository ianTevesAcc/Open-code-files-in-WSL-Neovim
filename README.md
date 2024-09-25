# Open-code-files-in-WSL-Neovim
This is a batch file script that allows WSL Windows users to open their code files from inside file explorer straight to their WSL file path. The `.bat` script is currently set to work with Ubuntu If your using a different distro, you can check out step 2 of the installation for more information.

![open files in nvim](https://github.com/user-attachments/assets/c199fc91-2002-48ae-ba4f-e76d8985e7ca)

# Installation
1. First make sure wsl is installed in your Windows machine. You can check this by running `wsl -v` in your command prompt console. If not you can install it with the following command `wsl --install` and install your chosen distro. Eg. `wsl install -d Ubuntu` to install the Ubuntu linux distro into your windows machine. You can read more here[https://learn.microsoft.com/en-us/windows/wsl/install](https://learn.microsoft.com/en-us/windows/wsl/install).
2. Edit `open_with_nvim.bat` file in order to run in your chosen linux distro. The `.bat` script is currently set to work with the Ubuntu distro, so it needs to be configurated to suit your distro file path. Edit `:ProcessYourDistroFilePath` and `start "" Ubuntu.exe run %command%` to suit your chosen distro. (Instruction on this are commented inside the `open_with_nvim.bat` script file).
3. Add `open_with_nvim.bat` file path into your Windows Environment Path. You can find a fleshed out tutorial here if you are unsure how to do so [https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/).
4. Open your file explorer and right click on your chosen code file.
    - click `Open with` and select `Choose another app`
    - scroll down and select `choose an app on your pc`
    - head to where you saved `open_with_nvim.bat` file path and select the `.bat` script file.
5. Your code file should now open in your wsl distro in neovim.

###### Update
The script is now configured to run a tmux session in the terminal session. This enables terminal use during session, enabling the ability to exit neovim without terminating the terminal shell session. 

*note... if you dont want to use a tmux session or do not have tmux enabled in your system, you can disable behaviour by removing commenting out line 93 `set "command=source ~/.zshrc; $(which tmux) new 'cd \"%ready_dir_path%\"; $(which nvim) \"%ready_file_path%\"'"` and uncomment line line 90 `rem "command=source ~/.zshrc; cd \"%ready_dir_path%\"; $(which nvim) \"%ready_file_path%\""`. by removing `rem` to uncomment and to add rem to comment out a line.

Testing...
