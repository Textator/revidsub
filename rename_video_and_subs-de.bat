@Echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
:: use %%nx & %%x if folder name has "." otherwise it's mistaken for extension of folder name and removed
FOR /D /R %%# in (*) DO (
    ::CD (every) dir found and store dir name in VAR %%#
    SET movieName=%%~xn#
    ECHO video file dir name: [95m^!movieName![0m
    PUSHD "%%#"
    ::rename forced to eng-forced if ENG language specified
    ::* wildcard for 0 or more characters
    ::? wildcard for 1 character only, but not DOT <.> - see: https://ss64.com/nt/syntax-wildcards.html
    IF EXIST subs\*eng-forced.* (
	ECHO forced-eng exists
	FOR %%1 in ("subs\*eng-forced.idx" "subs\*eng-forced.sub") DO (
        ECHO Moving:
        ECHO "%%~f1"
        ECHO TO:
        ECHO !movieName!.eng.forced%%~x1
        MOVE "%%1" "!movieName!.eng.forced%%~x1"
		)
    )
    IF EXIST subs\*eng.forced.* (
	ECHO forced.eng exists
    FOR %%1 in ("subs\*eng.forced.idx" "subs\*eng.forced.sub") DO (
        ECHO Moving:
        ECHO "%%~f1"
        ECHO TO:
        ECHO !movieName!.eng.forced%%~x1
        MOVE "%%1" "!movieName!.eng.forced%%~x1"
		)
    )
    ::rename "*eng.idx|*eng.sub" to "*.eng.idx|*.eng.sub" if ENG language specified
    IF EXIST subs\*eng.* (
    ECHO eng exists
    FOR %%2 in ("subs\*eng.idx" "subs\*eng.sub") DO (
        ECHO Moving:
        ECHO "%%~f2"
        ECHO TO:
        ECHO !movieName!.eng%%~x2
        MOVE "%%2" "!movieName!.eng%%~x2"
		)
	)
        ::## WARNING! ##
		::files without language attribute will be considered DEU for lack of working string search in file
		::find would have to be executed in .idx - also .sub has to be renamed accordingly (i.e. *.deu.sub)
		::therefore the attribute less files be checked and renamed at the end, so it works only for DEU files, assuming they are acctually DEU
    ::rename "*.idx|*.sub" to "*.deu.idx|*.deu.sub" if NO language specified
    FOR %%3 in ("subs\*.idx") DO (
			FIND /I "id: de" %%~f3
			IF !errorlevel! EQU 0 (
				ECHO Errorlevel: !errorlevel!
				ECHO found "id: de" in %%3
				ECHO Moving:
				ECHO "%%~f3"
				ECHO TO:
				ECHO !movieName!.deu%%~x3
				MOVE "%%3" "!movieName!.deu%%~x3"
				ECHO Moving SUBS:
				ECHO "%%~f3"
				ECHO TO:
				ECHO %%~p#%%~nx3
				::MOVE "%%#"\"%%s" %%~p#%%~nxs
				MOVE "%%#"\"%%3" ..\%%~nx3 ) ELSE ( ECHO FIND-command errorlevel: !errorlevel!
				ECHO [95m^Error: [0m"id: de" [95m^not found in .idx:[0m "%%3"
				ECHO [95m^Exiting batch, check folders and files manually![0m
				PAUSE
				EXIT
				) 
			) 
		::rename "*.sub" to "*.deu.sub" if NO language specified according to above
			FOR %%d in ("subs\*.idx" "subs\*.sub") DO (
					ECHO Moving:
					ECHO "%%~fd"
					ECHO TO:
					ECHO !movieName!.deu%%~xd
					MOVE "%%d" "!movieName!.deu%%~xd"
				)
    ::rename forced to deu-forced if NO language specified
    FOR %%4 in ("subs\*forced.idx" "subs\*forced.sub") DO (
        ECHO Moving:
        ECHO "%%~f4"
        ECHO TO:
        ECHO !movieName!.deu.forced%%~x4
        MOVE "%%4" "!movieName!.deu.forced%%~x4"
    )
    
	::move SUB FILES one folder up, NO more renaming
    FOR %%s in ("*.idx" "*.sub") DO (
        ECHO Moving SUBS:
        ECHO "%%~fs"
        ECHO TO:
        ECHO %%~p#%%~nxs
        ::MOVE "%%#"\"%%s" %%~p#%%~nxs
        MOVE "%%#"\"%%s" ..\%%~nxs
    )
    ECHO deleting Subs folder
    RD Subs /Q 2> nul ELSE ECHO no Subs folder found
		
    ::move VIDEO files folder up and RENAME
    FOR %%@ in ("*.mkv" "*.mp4" "*.avi" "*.wmv") DO (
        ECHO Moving:
        ECHO "%%~f@"
        ECHO TO:
        ECHO "%%~p#%%~nx#%%~x@"
        ::MOVE "%%#"\"%%@" %%~p#%%~nx#%%~x@
        MOVE "%%#"\"%%@" ..\%%~nx#%%~x@
		)
	
	::delete left overs	
    ECHO looking for left over files and dirs and delete them
			IF EXIST *.nfo (
    ECHO deleting .NFO file
    DEL *.nfo
    ) ELSE (
    ECHO no .nfo file found
    )
        IF EXIST *.jpg (
    ECHO deleting .JPG file
    DEL *.JPG
    ) ELSE (
    ECHO no .JPG file found
    )
            IF EXIST *.SFV (
    ECHO deleting .SFV file
    DEL *.SFV
    ) ELSE (
    ECHO no .SFV file found
    )
       		IF EXIST Sample\ (
    ECHO deleting SAMPLE folder
    RD sample\ /Q /S
    ) ELSE (
    ECHO no SAMPLE folder found
    )    
    		IF EXIST proof\ (
    ECHO deleting PROOF folder
    RD proof\ /Q /S
    ) ELSE (
    ECHO no PROOF folder found
    )
		POPD
	ECHO deleting base folder %%#
	RD %%# /Q
)
PAUSE
