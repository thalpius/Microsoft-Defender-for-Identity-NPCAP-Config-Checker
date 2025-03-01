<#
 
.SYNOPSIS
  This script check if NPCAP is configured correctly for Microsoft Defender for Identity
 
.DESCRIPTION
 
  Microsoft Defender for Identity uses NPCAP to inspect packets for malicious intent.
  Sometimes, NPCAP is not configured correctly for Microsoft Defender for Identity or
  NPCAP is installed by another program with different settings resulting in health
  issues reported by Microsoft Defender for Identity. This script will check the NPCAP
  settings which Microsoft Defender for Identity expects. If one of the items fail, validate
  if the setting can be changed to whatever it expects and restart the NPCAP service.
 
.EXAMPLE

  MDIcheckServices
  
.EXAMPLE

  MDIcheckRegistryProperty -registryKey 'HKLM:\\SOFTWARE\\Wow6432Node\\npcap' -registryProperty 'AdminOnly' -registryValue 0
  
.EXAMPLE

  MDIcheckRegistryKey -registryKey 'HKLM\\SYSTEM\\CurrentControlSet\\Services\\npcap\\Parameters' -registryProperty 'LoopbackAdapter'
  
.INPUTS
 
  None
 
.OUTPUTS
 
  Output will be shown in the terminal/console.
 
.NOTES
 
  Version:        0.1
  Author:         R. Roethof
  Creation Date:  07/27/2024
  Website:        https://thalpius.com
  Purpose/Change: Initial script development

#>

#------------------------------------------[Initialisations]---------------------------------------
 
# Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#-------------------------------------------[Declarations]-----------------------------------------

# Variables that can be set


#--------------------------------------------[Functions]-------------------------------------------

function MDIcheckServices {
    Param(
    )
    begin {
    }
    process {
        try {
            if ((Get-Service -Name npcap -ErrorAction SilentlyContinue) -or (Get-Service -Name npf -ErrorAction SilentlyContinue)) {
                Write-Host '[Pass] ' -ForegroundColor Green -NoNewline
                Write-Host 'Checking if NPCAP service or NPF service is running'
            }
            else {
                Write-Host '[Fail] ' -ForegroundColor Red -NoNewline
                Write-Host 'Checking if NPCAP service or NPF service is not running'
                
            }
        }
        catch {
            Write-Host $_.Exception
            exit
        }
    }
    end {
        if ($?) {
        }
    }
}

function MDIcheckRegistryProperty {
    Param(
    [parameter(Mandatory = $true, HelpMessage = "Specify the registry key")]
    [ValidateNotNullOrEmpty()]
    [string]$registryKey,
    [parameter(Mandatory = $true, HelpMessage = "Specify the registry property")]
    [ValidateNotNullOrEmpty()]
    [string]$registryProperty,
    [parameter(Mandatory = $true, HelpMessage = "Specify the registry value")]
    [ValidateNotNullOrEmpty()]
    [string]$registryValue
    )
    begin {
    }
    process {
        try {
            if ((Get-ItemProperty -Path $registryKey).$registryProperty -eq $registryValue) {
                Write-Host '[Pass] ' -ForegroundColor Green -NoNewline
                Write-Host 'Checking if property' $registryProperty 'in' $registryKey 'has the value' $registryValue
                
            }
            else {
                Write-Host '[Fail] ' -ForegroundColor Red -NoNewline
                Write-Host 'Checking if property' $registryProperty 'in' $registryKey 'has the value' $registryValue
            }
        }
        catch {
            Write-Host $_.Exception
            exit
        }
    }
    end {
        if ($?) {
        }
    }
}

function MDIcheckRegistryKey {
    Param(
    [parameter(Mandatory = $true, HelpMessage = "Specify the registry key")]
    [ValidateNotNullOrEmpty()]
    [string]$registryKey,
    [parameter(Mandatory = $true, HelpMessage = "Specify the registry property")]
    [ValidateNotNullOrEmpty()]
    [string]$registryProperty
    )
    begin {
    }
    process {
        try {
            if ((Get-ItemProperty -Path $registryKey).$registryProperty) {
                Write-Host '[Fail] ' -ForegroundColor Red -NoNewline
                Write-Host 'Checking if property' $registryProperty 'in' $registryKey 'does not exist'
                
            }
            else {
                Write-Host '[Pass] ' -ForegroundColor Green -NoNewline
                Write-Host 'Checking if property' $registryProperty 'in' $registryKey 'does not exist'
                
            }
        }
        catch {
            Write-Host $_.Exception
            exit
        }
    }
    end {
        if ($?) {
        }
    }
}

MDIcheckServices
MDIcheckRegistryProperty -registryKey 'HKLM:\\SOFTWARE\\Wow6432Node\\npcap' -registryProperty 'AdminOnly' -registryValue 0
MDIcheckRegistryProperty -registryKey 'HKLM:\\SOFTWARE\\Wow6432Node\\npcap' -registryProperty 'WinPcapCompatible' -registryValue 1
MDIcheckRegistryProperty -registryKey 'HKLM:\\SYSTEM\\CurrentControlSet\\Services\\npcap\\Parameters' -registryProperty 'AdminOnly' -registryValue 0
MDIcheckRegistryProperty -registryKey 'HKLM:\\SYSTEM\\CurrentControlSet\\Services\\npcap\\Parameters' -registryProperty 'LoopbackSupport' -registryValue 1
MDIcheckRegistryProperty -registryKey 'HKLM:\\SYSTEM\\CurrentControlSet\\Services\\npcap\\Parameters' -registryProperty 'WinPcapCompatible' -registryValue 1
MDIcheckRegistryKey -registryKey 'HKLM\\SYSTEM\\CurrentControlSet\\Services\\npcap\\Parameters' -registryProperty 'LoopbackAdapter'