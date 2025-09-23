@echo off
setlocal enabledelayedexpansion

set "filename=file.txt"
set "git_repo_path=C:\Users\fitzg\Downloads\test"

cd /d "%git_repo_path%"

:loop
set "line="
(for /f "delims=" %%a in (%filename%) do (
    set "line=%%a"
    set "line=!line:A=B!"
    echo !line!
)) > temp.txt

move /y temp.txt %filename%

git add %filename%
git commit -m "Change A to B"
git push origin main

set "line="
(for /f "delims=" %%a in (%filename%) do (
    set "line=%%a"
    set "line=!line:B=A!"
    echo !line!
)) > temp.txt

move /y temp.txt %filename%

git add %filename%
git commit -m "Change B back to A"
git push origin main

timeout /t 5 > nul
goto loop