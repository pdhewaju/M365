Connect-MsolService

$imported= Import-Csv -Path D:\hardmatchuser.csv

$imported | ForEach-Object {

    # Hardmataching existing user
    Write-Host "Generating Immutable ID"
    
    $guid = (get-Aduser $_.id).ObjectGuid
    $immutableID = [System.Convert]::ToBase64String($guid.tobytearray())

    Write-host "Setting Immutable ID"

    Set-MSOLuser -UserPrincipalName $_.upn -ImmutableID $immutableID

    Write-Host $_.id "impersonated the users at cloud" $_.upn

           
    # change the UserPrincipalName of the user

    <#
    Set-ADUser $_.id -UserPrincipalName $_.upn

    Write-Host "Changing UPN of user" $_.id

    #move user to the ADSync-test OU

    $udn = (Get-ADUser $_.id).DistinguishedName
    Move-ADObject $udn -TargetPath "OU=ADSync-Test,DC=snpl,DC=net,DC=np"
    
    Write-host "Moved user $($_.id) to ADsync-Test OU" 
    #>

    }
