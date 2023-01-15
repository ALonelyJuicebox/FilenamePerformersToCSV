<#
---Filename Performers to CSV PoSH Script 0.2---

AUTHOR
    JuiceBox
URL 
    https://github.com/ALonelyJuicebox/FilenamePerformersToCSV

DESCRIPTION
    Parse performer names from your media filenames into CSV files for batch import into Stash!

REQUIREMENTS
    Powershell
 #>

clear-host
write-host "Filenames to Performer CSV `nBy Juicebox" -ForegroundColor Cyan
write-host "`nThis script allows you to pull performer names from your filenames and export them to a CSV file.`n`n--"

write-host "`nFilenames that will work well with this script!" -ForegroundColor Green
write-host "- [studio name in brackets] <performer name>, <performer name>, - Studio - Scene name - Misc Other Details.mp4"
write-host "- [Tacked] Jane Doe, Alyssa Roberts, Amanda Quinn - Jane goes to the Optometrist.mp4"
write-host "- Jane Doe - Jazzers - Jane goes to the Dentist.mp4"

write-host "`nFilenames that will not work well with this script..." -ForegroundColor red
write-host "- Jane_Jazzers_doctorvisit.mp4 "
write-host "- Jane.Jazzers.doctor.visit.mp4 "

$foldertoscan = read-host "`n--`n`nWhat's the folder path to your media files?"
if (!(Test-Path $foldertoscan)){
    read-host "Could not find path. Press [Enter] to exit and try again."
    exit
}
if(test-path ".\Performers.csv"){
    write-host "Just a heads up, you have a 'Performers.csv' file in this directory already and it will be overwritten if you continue." -ForegroundColor cyan
    read-host "`nPress [Enter] to continue"
}
write-host "Scanning for media..."
$Media_Files = Get-Childitem $foldertoscan\* -include *.mp4, *.mov, *.wmv, *.avi, *.mpg, *.mpeg, *.rmvb, *.rm, *.flv, *.asf, *.mkv, *.webm -recurse

$mediacounter = 0 #Used for tracking how many media files have been iterated over
foreach ($mediafilename in $Media_Files){
    $mediafilename = $mediafilename.basename

    #Basically we want to remove the studio from the filename which we'll do with the split function
    if ($mediafilename -like '*]*'){
        $mediafilename = $mediafilename -split ']' 
        $mediafilename = $mediafilename[1]
        $mediafilename = $mediafilename.trimstart()
    }

    $arrperformers = $mediafilename -split '-' #split on the dash (indicating the end of the list of performers)
    $arrperformers = $arrperformers[0] -split ',' #Now we parse out each performer by splitting them out into an array using commans
    
    foreach ($performer in $arrperformers){
        $performer = $performer.Trim()   
        $performer = $performer +', ' #We add a comma BEFORE doing a dupe check to help avoid accidental matches.
       
        #Only add this performer to the list if we can assure ourselves that this performer doesn't already exist in the list
        if ($output -notlike "*$performer*"){
            $output = $output+$performer
            $performer = $performer.trimEnd(', ') #Just removing the comma for cosmetic reasons 
            write-host "Discovered performer:" $performer
            $performercounter++
        }
    }
    $mediacounter++
}
$output = $output.TrimEnd(' ,')
$output | out-file .\Performers.csv
write-host "...OK!"
write-host "`n$performercounter performers were found in $mediacounter media files. " -ForegroundColor Cyan
write-host "`bWe wrote these performer names to the file 'Performers.csv'. `nThis file is located in the same directory as this script.`n"