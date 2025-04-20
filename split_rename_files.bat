rem windows bat script to rename all files in current directory. Splits names on " - " and retains second part of name
rem Example - "www.downloadsite.com - Name of the file.txt"   -> "Name of the file.txt"
@echo off
setlocal enabledelayedexpansion

rem Loop through all files in the current directory
for %%f in (*) do (
    rem Get the full file name
    set "filename=%%~nf"
    set "extension=%%~xf"

    rem Check if the filename contains " - "
    echo "!filename!" | findstr /c:" - " >nul
    if !errorlevel! equ 0 (
        rem Split the filename based on " - "
        for /f "tokens=1,* delims=-" %%a in ("!filename!") do (
            set "newname=%%b"
        )

        rem Trim leading spaces from the new name
        set "newname=!newname:~1!"

        rem Rename the file if the new name is not empty
        if defined newname (
            ren "%%f" "!newname!!extension!"
            echo Renamed "%%f" to "!newname!!extension!"
        )
    ) else (
        echo Skipped "%%f" (no " - " found)
    )
)

endlocal
