# FilenamePerformersToCSV


![Image of a PowerShell terminal with this script running](https://github.com/ALonelyJuicebox/FilenamePerformersToCSV/blob/main/filenametoperformer.png?raw=true)

**Parse performer names from your media filenames into CSV files for batch import into Stash!**

This script (`FilenamePerformersToCSV.js`) exports performer names into a CSV file from your media files. This is a *great* tool if you need to batch import performers into your Stash for some reason.
 
 
## Setup
- Ensure your Stash [is connected to StashDB](https://docs.stashapp.cc/docs/Beginner-Guides/Guide-To-Scraping/)
- Download and run [FilenamePerformersToCSV.ps1](https://github.com/ALonelyJuicebox/FilenamePerformersToCSV/blob/main/FilenamePerformersToCSV.ps1)
- Enter the folder you want to parse when prompted
- Open the `Performers.CSV` file that is generated and copy its contents into your clipboard.
- In Stash, navigate to **Performers** then click on the icon that looks like two little luggage tags on the far right to enter Tagger mode
- Click on the **Batch Add Performers** button
- Paste the contents of your clipboard and click **Add New Performers**
 
## Additional Details 
- Your files MUST align with what this script is expecting. Aka, the performer name followed by a dash indicating there are no more performer names. 

Hope this helps someone!
