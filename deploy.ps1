#region Script preferences
#Remove cached variables
#Remove-Variable * -ErrorAction SilentlyContinue;

#Error preferences
$WarningPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"
#endregion

#region Azure Login.
#Login-AzureRmAccount
#$Subscription              = Get-AzureRmSubscription | Out-GridView -Title "Select the Azure subscription..." -PassThru
#Select-AzureRmSubscription -SubscriptionId $Subscription.SubscriptionId
#endregion

#region Parameters
$RG_Name=      'demoin'
$location=     'eastus'
$paramUri=    'https://raw.githubusercontent.com/AirVault/azure-scripts/master/demo/params.json?token=Aok8HlwZeXsG3Z21mYP6cWFGfQEJrQfdks5b6F34wA%3D%3D'
$masterTemplateUri=  'https://raw.githubusercontent.com/AirVault/azure-scripts/master/demo/master.json?token=Aok8Hr6QH1JR0ZVuSfwBvC-l2K5lygZuks5b6F5KwA%3D%3D'

#Check or Create Resource group
Get-AzureRmResourceGroup -Name $RG_Name -ev notPresent -ea 0
if ($notPresent) { Write-Host "Failover RG '$RG_Name' does not exist.Creating new in $location..." -ForegroundColor Yellow
New-AzureRmResourceGroup -Name $RG_Name -Location $location
} else { Write-Host "Using existing resource group '$RG_Name'"-ForegroundColor Yellow ;}

#region deploy
New-AzureRmResourceGroupDeployment -ResourceGroupName $RG_Name -Mode Incremental -TemplateParameterFile $paramFile -TemplateUri $masterTemplateUri -Verbose
#endregion
