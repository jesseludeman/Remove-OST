function Remove-OST
{
    [cmdletbinding()]
    param (
    
        [Parameter(ValueFromPipeline)]
        $ComputerName
    )
    process 
    { 
        if ((Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) -and (Test-Path "\\$ComputerName\c$"))
        {
            # Advise admin what computer I'm working on
            Write-Host -ForegroundColor Yellow "$ComputerName is online - looking for Outlook profiles"

            # Locate the files and remove them
            Get-ChildItem "\\$ComputerName\c$\Users\*\AppData\Local\Microsoft\Outlook" -Include *.ost -Recurse | foreach { "Removing file $($_.FullName)"; Remove-Item $_ -Force }
        }
        else
        {
            Write-Host -ForegroundColor Red "$ComputerName is offline"
        }

    }
}