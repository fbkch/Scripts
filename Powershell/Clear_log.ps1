<#
Clear security log for remote server SVR01
#>

Get-EventLog -list
Clear-EventLog -logname Application, Security -computername SVR01
