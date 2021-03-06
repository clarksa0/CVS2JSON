<# Adds string to first line of file #>	   
Function Insert-Content {
Param ( [String]$Path )
Process {
$( ,$_; Get-Content $Path -ea SilentlyContinue) | Out-File $Path
}
}

<# Get all text files #>
$FilesInDir = Get-ChildItem "*.txt" | select -Expand Name   
$FileNumber = 0
	   <# Process each text file #>
       ForEach ($File In $FilesInDir)
       {
	   <# Save header string #>
        $Header = Get-Content $file -First 1
			<# Split files to 150 rows each #>
            $SplitFiles = Get-Content .\$File -ReadCount:150
              $SplitFiles | ForEach {
                Set-Content $_ -Path .\$File-$FileNumber.Dat
				<# Insert header to all files for JSON prep #>
        		if ($FileNumber -gt 0) {$Header | Insert-Content $_ -Path .\$File-$FileNumber.Dat}
					<# Import csv file and convert to json #>
                    Import-CSV -Delimiter `t .\$File-$FileNumber.Dat  | ConvertTo-Json | Add-Content -Path .\$File-$FileNumber.json 
					<# Upload file to AWS S3 bucket #>
					Write-S3Object -BucketName replace_with_bucket -File .\$File-$FileNumber.json
					<# Delete files #>
					Remove-Item -Path .\$File-$FileNumber.Dat
					Remove-Item -Path .\$File-$FileNumber.json
		            $FileNumber++
		        } 
              $FileNumber = 0
       } 

