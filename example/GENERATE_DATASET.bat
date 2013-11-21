set CURRENTDIR=%CD%

set SEQUENCESDIR=%CURRENTDIR%\replay\
set DATASETDIR=%CURRENTDIR%\dataset\
set VDRIFTDIR=..\

set CAMDIR=%DATASETDIR%cam
set DEPDIR=%DATASETDIR%depth
set FLXDIR=%DATASETDIR%flow_x
set FLYDIR=%DATASETDIR%flow_y
set SEGDIR=%DATASETDIR%seg
set POSDIR=%DATASETDIR%pos

set FRAMES_TO_RECORD=5

cd %VDRIFTDIR%





rem WEEKEND
set CARLIST=%SEQUENCESDIR%carlist.txt
set REPLAY=%SEQUENCESDIR%04-17-21-38-45-monaco.vdr
set SEQID=1
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %CAMDIR% -dataset_mode 0
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %DEPDIR% -dataset_mode 1
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %FLXDIR% -dataset_mode 2
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %FLYDIR% -dataset_mode 3
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %SEGDIR% -dataset_mode 4
vdrift.exe -record -frames_to_record %FRAMES_TO_RECORD% -replay %REPLAY% -carlist %CARLIST% -seq %SEQID% -dataset_folder %POSDIR% -dataset_mode 5

cd %CURRENTDIR%