$ResourceGroup = 'SandeepGroup'
$StorageAccountName = 'runbookstor'
$StorageSKU = 'Standard_LRS'
$Location = 'centralus'
# Authenticate to Azure
$ServicePrincipalConnection = Get-AutomationConnection -Name "AzureRunAsConnection"
Login-AzureRmAccount `
    -ServicePrincipal `
    -TenantId $ServicePrincipalConnection.TenantId `
    -ApplicationId $ServicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint | Write-Verbose

# Create new storage account
New-AzureRmStorageAccount -ResourceGroupName $ResourceGroup -Name $StorageAccountName -SkuName $StorageSKU -Location $Location
