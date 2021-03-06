# Load the Helper Module
Import-Module -Name "$PSScriptRoot\..\Helper.psm1" -Verbose:$false

data LocalizedData
{
    # culture="en-US"
    ConvertFrom-StringData -StringData @'
VerboseTestTargetSSLCertificateNull = A SSL Certificate is not yet installed or configured. 
VerboseTestTargetSSLCertificateNoMatch = The specified thumbprint does not match the current value.
VerboseTestTargetTrueResult = The target resource is already in the desired state. No action is required. 
VerboseTestTargetFalseResult = The target resource is not in the desired state. 
VerboseSetTargetSSLCertificate = Successfully installed certificate with thumbprint "{0}". 


'@

}

function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Thumbprint
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    Thumbprint = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Thumbprint
    )

    Assert-Module
    Assert-Certificate -thumbprint $Thumbprint

    $sslcertificate = Get-ChildItem -Path RDS:\GatewayServer\SSLCertificate
    if($sslcertificate.CurrentValue -eq 'NULL' -or $sslcertificate.CurrentValue -ne $Thumbprint)
    {
        Set-Item -Path RDS:\GatewayServer\SSLCertificate\Thumbprint -Value $Thumbprint
        Write-Verbose -Message ($LocalizedData.VerboseSetTargetSSLCertificate -f $Thumbprint)
        Restart-Service tsgateway
    }
    #$global:DSCMachineStatus = 1

}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Thumbprint
    )

    Assert-Module
    Assert-Certificate -thumbprint $Thumbprint
    $InDesiredState = $true

    $sslcertificate = Get-ChildItem -Path RDS:\GatewayServer\SSLCertificate
    if($sslcertificate.CurrentValue -eq 'NULL')
    {
        $InDesiredState = $false
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetSSLCertificateNULL)
    }
    elseif($sslcertificate.CurrentValue -ne $Thumbprint)
    {
        $InDesiredState = $false
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetSSLCertificateNoMatch)
        #Check if cert already exists in store, else error.
    }



    if ($InDesiredState -eq $true) 
    { 
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetTrueResult) 
    } 
    else 
    { 
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseResult) 
    } 

    return $InDesiredState 

}


Export-ModuleMember -Function *-TargetResource

