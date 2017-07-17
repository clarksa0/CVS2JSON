# TXT2JSON
Powershell Script to reformat .txt files from PI Integrator for BA to JSON for AWS

Replace <replace_with_bucket> with your bucket name.

The script requires AWS Tools for Windows Powershell.

Run this script from the same directory as your input files.

You can test the json generating piece by commenting out this bit:

#Write-S3Object -BucketName replace_with_bucket -File .\$File-$FileNumber.json
<# Delete files #>
#Remove-Item -Path .\$File-$FileNumber.Dat
#Remove-Item -Path .\$File-$FileNumber.json
