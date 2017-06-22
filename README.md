# https://www.linkedin.com/in/rimvydas/
#
# This scripts does the following:
# - Login to Azure Account
# - Gets and selects (uncomment) subscription
# - Lists available VM sizes for your subscription and selected region (uncomment)
# - Creates resource group and VNet (with subnets) using defined names
# - Sets VM size and creates new (windows) VM using your custom VHD disk (must be uploaded as fixed VHD, as Page Blob to your storage account)
# - Deletes created resource group and it's content
