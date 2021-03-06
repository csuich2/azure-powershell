#
# Module manifest for module 'PSGet_AzureRM.Insights'
#
# Generated by: Microsoft Corporation
#
# Generated on: 11/3/2017
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '4.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '698c387c-bd6b-41c6-82ce-721f1ef39548'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Microsoft Azure PowerShell - Insights service cmdlets for Azure Resource Manager'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.5.2'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName = 'AzureRM.Profile'; ModuleVersion = '4.1.1'; })

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = '.\Microsoft.Azure.Management.Monitor.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = '.\Microsoft.Azure.Commands.Insights.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('.\Microsoft.Azure.Commands.Insights.dll')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = 'Get-AzureRmMetricDefinition', 'Get-AzureRmMetric', 
               'Remove-AzureRmLogProfile', 'Get-AzureRmLogProfile', 
               'Add-AzureRmLogProfile', 'Get-AzureRmLog', 
               'Set-AzureRmDiagnosticSetting', 'Get-AzureRmDiagnosticSetting', 
               'New-AzureRmAutoscaleNotification', 'New-AzureRmAutoscaleProfile', 
               'New-AzureRmAutoscaleRule', 'Add-AzureRmAutoscaleSetting', 
               'Get-AzureRmAutoscaleHistory', 'Get-AzureRmAutoscaleSetting', 
               'New-AzureRmAutoscaleWebhook', 'Remove-AzureRmAutoscaleSetting', 
               'Add-AzureRmMetricAlertRule', 'Add-AzureRmWebtestAlertRule', 
               'Get-AzureRmAlertHistory', 'Get-AzureRmAlertRule', 
               'New-AzureRmAlertRuleEmail', 'New-AzureRmAlertRuleWebhook', 
               'Remove-AzureRmAlertRule', 'Set-AzureRmActivityLogAlert', 
               'Get-AzureRmActivityLogAlert', 'New-AzureRmActionGroup', 
               'New-AzureRmActivityLogAlertCondition', 
               'Enable-AzureRmActivityLogAlert', 'Disable-AzureRmActivityLogAlert', 
               'Remove-AzureRmActivityLogAlert', 'New-AzureRmActionGroupReceiver', 
               'Set-AzureRmActionGroup', 'Get-AzureRmActionGroup', 
               'Remove-AzureRmActionGroup'

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Azure','ResourceManager','ARM','Insights'

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* NOTE: This is a breaking change release. Please see the migration guide (https://aka.ms/azps-migration-guide) for a full list of breaking changes introduced.
* **Add-AzureRMLogAlertRule**
    - After October 1st using this cmdlet no longer had any effect as this functionality was transitioned to Activity Log Alerts. Please see https://aka.ms/migratemealerts for more information.
* **Get-AzureRMUsage**
    - Deprecated as announced since April 2017
* **Add-AzureRmMetricAlertRule** / **Add-AzureRmWebtestAlertRule**
    - The argument ResourceGroup has been renamed as ResourceGroupName
    - The parameter Actions has been renamed to Action and the Actions has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **Add-AzureRmAutoscaleSetting**
    - The argument ResourceGroup has been renamed as ResourceGroupName, i.e. a non-breaking change.
    - The parameter AutoscaleProfiles has been renamed to AutoscaleProfiles and the AutoscaleProfiles has been added to the alias list
    - The parameter Notifications has been renamed to Notification and the Notifications has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **Remove-AzureRmAutoscaleSetting**
    - The argument ResourceGroup has been renamed as ResourceGroupName
* **Get-AzureRmAlertRule**
    - The argument ResourceGroup has been renamed as ResourceGroupName
    - Warning message added for the future deprecation of the DetailedOutput parameter.
* **Remove-AzureRmAlertRule**
    - The argument ResourceGroup has been renamed as ResourceGroupName
    - The cmdlet now implements the ShouldProcess protocol.
* **Get-AzureRmAutoscaleSetting**
    - The argument ResourceGroup has been renamed as ResourceGroupName
    - Warning message added for the future deprecation of the DetailedOutput parameter.
* **Remove-AzureRmLogProfile**
    - The cmdlet now implements the ShouldProcess protocol.
* **Add-AzureRmLogProfile**
    - The parameter Locations has been renamed to Location and the Locations has been added to the alias list
    - The parameter RetentionInDays has been renamed to RetentionInDay and the RetentionInDays has been added to the alias list
    - The parameter Categories has been renamed to Category and the Categories has been added to the alias list
    - The cmdlet now implements the ShouldProcess protocol.
    - Warning message about the future deprecation of the plural parameter names added.
* **Get-AzureRmMetricDefinition** / **Get-AzureRmMetric**
    - The parameter MetricNames has been renamed to MetricName and the MetricNames has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **Get-AzureRmLog**
    - Warning message added for the future deprecation of the DetailedOutput parameter.
    - The parameter MaxEvents has been renamed as MaxRecord (there was already an alias MaxRecords which is kept.) MaxEvents has been moved to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **Get-AzureRmAlertHistory** / **GetAzureRmAutoscaleHistory**
    - Warning message added for the future deprecation of the DetailedOutput parameter.
* **New-AzureRmAutoscaleNotification**
    - The parameter SendEmailToSubscriptionCoAdministrators has been renamed to SendEmailToSubscriptionCoAdministrator and the SendEmailToSubscriptionCoAdministrators has been added to the alias list
    - The parameter CustomEmails has been renamed to CustomEmail and the CustomEmails has been added to the alias list
    - The parameter Webhooks has been renamed to Webhook and the Webhooks has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **New-AzureRmAutoscaleProfile**
    - The parameter ScheduleDays has been renamed to ScheduleDay and the ScheduleDays has been added to the alias list
    - The parameter ScheduleHours has been renamed to ScheduleHour and the ScheduleHours has been added to the alias list
    - The parameter ScheduleMinutes has been renamed to ScheduleMinute and the ScheduleMinutes has been added to the alias list
    - The parameter Rules has been renamed to Rule and the Rules has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **New-AzureRmAutoscaleWebhook**
    - The parameter Properties has been renamed to Property and the Properties has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **New-AzureRmAlertRuleEmail**
    - The parameter CustomEmails has been renamed to CustomEmail and the CustomEmails has been added to the alias list
    - The parameter SendToServiceOwners has been renamed to SendToServiceOwner and the SendToServiceOwners has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* **New-AzureRmAlertRuleWebhook**
    - The parameter Properties has been renamed to Property and the Properties has been added to the alias list
    - Warning message about the future deprecation of the plural parameter names added.
* Add support for online help
    - Run Get-Help with the -Online parameter to open the online help in your default Internet browser'

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

