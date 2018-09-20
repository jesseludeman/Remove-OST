function Delete-OST()
{


    # Get a list of computers
    $ComputerList = Get-Content C:\PowerShell\ComputerList.txt

    # List the OST files
    foreach ($computer in $ComputerList)
    {
        Get-ChildItem "\\$computer\c$\users\*\appdata\local\microsoft\outlook" -Include *.ost -Recurse | Remove-Item -Force -WhatIf # Remove the -WhatIf to confirm deletion
    }


}