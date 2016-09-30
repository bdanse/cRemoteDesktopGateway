# Localized messages
data LocalizedData
{
    # culture="en-US"
    ConvertFrom-StringData @'
    RoleNotFound    =   Please ensure that the PowerShell module for role {0} is installed
    CertificateNotFound    =   Please ensure that the Certificate with correct thumbprint {0} is installed
'@
}

# Internal function to throw terminating error with specified errroCategory, errorId and errorMessage
function New-TerminatingError
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [String] $ErrorId,

        [Parameter(Mandatory)]
        [String] $ErrorMessage,

        [Parameter(Mandatory)]
        [System.Management.Automation.ErrorCategory] $ErrorCategory
    )

    $exception = New-Object System.InvalidOperationException $errorMessage
    $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null
    throw $errorRecord
}

# Internal function to assert if the role specific module is installed or not
function Assert-Module
{
    [CmdletBinding()]
    param
    (
        [String] $moduleName = 'RemoteDesktopServices'
    )

    if(-not (Get-Module -Name $moduleName -ListAvailable))
    {
        $errorMsg = $($LocalizedData.RoleNotFound) -f $moduleName
        New-TerminatingError -ErrorId 'ModuleNotFound' -ErrorMessage $errorMsg -ErrorCategory ObjectNotFound
    }
    Import-Module $moduleName
    
}

function Assert-Certificate
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [String] $thumbprint
    )

    if(-not (Get-Item ('Cert:\LocalMachine\My\{0}' -f $Thumbprint) -ErrorAction Ignore))
    {
        $errorMsg = $($LocalizedData.CertificateNotFound) -f $Thumbprint
        New-TerminatingError -ErrorId 'CertificateNotFound' -ErrorMessage $errorMsg -ErrorCategory ObjectNotFound
    }
   
}