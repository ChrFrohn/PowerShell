<#
Det script jeg har lavet læser navnene på filerne i den mappe scriptet bliver lagt i. Ud fra det navn filen har nu, vil det blive det ændret til det navn som er angivet.

Det er vigtigt at de navne som står i Excel ark matcher de filer som er i mappen. Ellers vil de blive sprunget over.

OBS! Det NYE navn til filerne må ikke indeholde følgende tegn: ~ " # % & * : < > ? / \ { | } og ,
-	Der må ikke være komma fordi scriptet adskiller det gamle filnavn for det nye filnavn ud fra det. Jeg anbefaler og bruge punktum i stedet for komma i det nye navn.
OBS!! Husk og tage backup af filerne inden. Handlingen kan ikke fortrydes.


Her er metoden til og omdøbe filerne på:
1.	Lav en .CSV fil med navnet ”Rename” (altså Rename.csv)
2.	i Kolonne A i A1 skriv: Oldname,Newname
3.	Kopier listen med aktuel filavne ind i kolonne B
4.	Kopier listen med de nye navne ind i Kolonne C
5.	I kolonne A2 skriver du følgende: =B2&”,”&C2
6.	Gør det samme for alle cellerne i kolonne A (Træk og slip)
7.	Slet Kolonne B og C
8.	Gem og luk filen.
9.	Højre klik på din .CSV fil og vælg ”Open with” og vælg ”Notepad”
10.	Vælg ”File”, derefter ”Save-As”
11.	Under den linje hvor der skal skrives et navn på filen tryk på pilen ud for ”Encoding”
12.	Vælg UTF-8 i Encoding under filnavn og tryk på save
13.	Flyt .CSV filen + script filen til den mappe filerne ligger i.
14.	Doble klik på script filen.



#>


$Path = Get-Location
$csv = Import-Csv $Path\Rename.csv
$files = Get-ChildItem $Path -File

foreach($line in $csv){
  foreach($file in $files){
      if(($file.name) -eq ($line.oldname+$file.Extension)){
         Rename-Item $file.fullname -NewName ($line.newname+$file.Extension) -Verbose 
      }
  }
} 
