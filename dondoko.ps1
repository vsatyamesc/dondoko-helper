param (
    # This allows you to pass the link as an argument when running the script
    [string]$BaseLink
)

# =====================================================================
# UPDATE THIS PATH to wherever you saved link_generator.py
$PythonScriptPath = "./dondoko.py"
# =====================================================================

# Check if the user passed a link argument; if not, prompt for it
if ([string]::IsNullOrWhiteSpace($BaseLink)) {
    $BaseLink = Read-Host "No link provided. Please enter the base link (e.g., https://example.com/images/)"
}

# If you just pressed Enter without typing anything, exit gracefully
if ([string]::IsNullOrWhiteSpace($BaseLink)) {
    Write-Host "[Error] No link entered. Exiting..." -ForegroundColor Red
    exit
}

# Run the python script, pass the link, and redirect output to pages.txt
# The '&' is the call operator, required in PowerShell to run external commands reliably
& python $PythonScriptPath $BaseLink | Out-File -FilePath "pages.txt" -Encoding UTF8

# Check if the output file actually got populated
if (Test-Path "pages.txt") {
    $fileSize = (Get-Item "pages.txt").Length
    if ($fileSize -gt 0) {
        Write-Host "[Success] Links successfully generated and saved to pages.txt!" -ForegroundColor Green
    } else {
        Write-Host "[Notice] No images found. pages.txt is empty." -ForegroundColor DarkYellow
    }
}