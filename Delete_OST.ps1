function Delete-OST()
{


    # Get a list of computers
    $ComputerList = Get-Content C:\PowerShell\ComputerList.txt

    # Loop over the computer list
    foreach ($computer in $ComputerList)
    {
        # Check if computer is online
        if (Test-Connection -ComputerName $computer -Count 2 -Quiet)
        {
            # Display to user
            Write-Host "Working on $computer..."

            # Store the .ost files here...
            $ost = Get-ChildItem "\\$computer\c$\users\*\AppData\Local\Microsoft\Outlook" -Include *.ost -Recurse
            
            # Check the path exists, then remove the file
            if ($ost | Test-Path)
            {
                Remove-Item $ost -Force
            }
            if (-not($ost | Test-Path))
            {
                Write-Host -ForegroundColor Yellow "No Outlook profiles detected"
            }
        }

        # Otherwise ignore the computer
        else
        {
            Write-Host -ForegroundColor Yellow "$computer is offline..."
        }

    }


}