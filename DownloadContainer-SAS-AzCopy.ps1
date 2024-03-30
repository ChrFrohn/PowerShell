#Requries AzCopy - https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
#Set location to where AzCopy.exe is located

#Paste in SAS token - https://docs.microsoft.com/en-us/azure/cognitive-services/translator/document-translation/create-sas-tokens?tabs=Containers
$SAS = ""

#Copies cotainer content from blob to local computer path using SAS
.\azcopy.exe copy "https://STORAGEACOUNTNAME.blob.core.windows.net/CONTAINER/$SAS" --recursive "CopyFromFolderPath"
