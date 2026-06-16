@echo off
setlocal

:: =====================================================================
:: UPDATE THIS PATH to wherever you saved link_generator.py
set PYTHON_SCRIPT_PATH="./dondoko.py"
:: =====================================================================

:: Check if the user passed a link argument; if not, prompt for it
set "BASE_LINK=%~1"

if "%BASE_LINK%"=="" (
    set /p BASE_LINK="No link provided. Please enter the base link (e.g., https://example.com/images/): "
)

:: If you just pressed Enter without typing anything, exit gracefully
if "%BASE_LINK%"=="" (
    echo [Error] No link entered. Exiting...
    exit /b 1
)

:: Run the python script, pass the link, and redirect output to pages.txt
python %PYTHON_SCRIPT_PATH% "%BASE_LINK%" > pages.txt

:: Check if the output file actually got populated
for %%I in (pages.txt) do set size=%%~zI
if %size% GTR 0 (
    echo [Success] Links successfully generated and saved to pages.txt!
) else (
    echo [Notice] No images found. pages.txt is empty.
)

endlocal