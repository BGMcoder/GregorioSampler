;Simple Compile Script for Gregorio.
;Tuesday, March 10, 2015
;by Brother Gabriel-Marie
;Just a simple script to compile a gabc file to pdf; easily modifiable to accomodate multiple scripts in multiple directories.

#SingleInstance,Force
#noenv
fileencoding, UTF-8

;filename variables - just set the names here - without file extensions
;if you want to compile just a gabc, then set the texname blank (blank being nothing)
;if you want to copile just a tex file, then set the gabcname to blank
gabcname = gregoriocodesheet
texname = main-lualatex

;set to false to run in batch mode without any console; set to true if you need to debug
hideconsole := false
;set cleanup to false to not automatically delete the .aux files and .log files, etc.
cleanup := true
;---------------------------------------------------------------------------------------------------------
;makes sure our pdf is not already open in Adobe Reader
winclose, %texname%.pdf - Adobe Reader
;compile the gabc file
if(gabcname){
	runwait, gregorio %gabcname%.gabc
}

;compile the text file to pdf
if(texname){
	if(hideconsole){
		runwait, lualatex --shell-escape %texname%.tex \batchmode,,"hide"
	}else{
		runwait, lualatex --shell-escape %texname%.tex 
	}
	;open the pdf file
	run, %texname%.pdf	
}

if(cleanup){
	;clean up some files we don't need
	filedelete *.aux
	filedelete *.gaux
	filedelete *.log
	filedelete *.gtex
}