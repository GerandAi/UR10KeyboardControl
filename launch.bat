::@echo off
cd bin
start sync.py
cd ..
cd socket
start startup.py
cd ..
cd bin
timeout /t 7
start keyboardControl.bat
