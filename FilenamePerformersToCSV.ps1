clear-host
write-host "Filenames to Performer CSV-anator `nBy Juicebox" -ForegroundColor Cyan
write-host "--`nThis script works best with filenames that have performer names separated by commas,`nfollowed by a dash which separates the performer names from everything else"
write-host "`nExamples of filenames that will work well with this script" -ForegroundColor Green
write-host "- <performer name>, <performer name>, - Studio - Scene name - whatever else.mp4"
write-host "- Jane Doe, Yessica Roberts, Paige Quinn - Jazzers - Jane goes to the Dentist.mp4"
write-host "- Jane - Jazzers - Jane goes to the Doctor.mp4"

write-host "`nExamples of filenames that will not work well with this script" -ForegroundColor red
write-host "- Jane_Jazzers_doctorvisit.mp4 "

$foldertoscan = read-host "`nWhat's the folder path to your media files?"
if (!(Test-Path $foldertoscan)){
    read-host "Could not find path. Press [Enter] to exit and try again."
    exit
}
if(test-path ".\Performers.csv"){
    write-host "Just a heads up, you have a 'Performers.csv' file in this directory already and it will be overwritten if you continue." -ForegroundColor cyan
    read-host "Press [Enter] to continue"

}

$Media_Files = Get-Childitem $foldertoscan\* -include *.mp4, *.mov, *.wmv, *.avi, *.mpg, *.mpeg, *.rmvb, *.rm, *.flv, *.asf, *.mkv, *.webm -recurse
$counter = 0
foreach ($filename in $Media_Files){
    $arrperformers = $filename.BaseName -split '-'
    $arrperformers = $arrperformers[0] -split ','
    foreach ($performer in $arrperformers){
        $performer = $performer.Trim()+', '
        $output = $output+$performer
        $counter++
    }
}
$output = $output.TrimEnd(' ,')
$output | out-file .\Performers.csv
write-host "...OK!`n$counter performers were written to the file 'Performers.csv',`nwhich is located in the same directory as this script.`n"