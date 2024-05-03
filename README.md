# revidsub
Windows CMD batch to rename video (.mkv, .mp4, .avi, .wmv) like parent directory and rename subtitle files (.idx, .sub) accordingly and move them to the same (upper) directory and delete uneccessary files.

**Warning!**
Using *FIND* to determine language of .idx (does it contain string "id: de") doesn't work, yet. So for now it's assumend, the .idx without language attribute is de/DEU/German

## Example
### Usage:
run batch in main folder which holds subfolders with videos and subs sub-dirs
#### Before:
```
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\example-video.s01e01-1080p.mkv
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\example-video.s01e01-1080p.nfo
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\Subs
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\Subs\example-video.s01e01-1080p-eng.idx
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\Subs\example-video.s01e01-1080p-eng.sub
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\Subs\example-video.s01e01-1080p.idx
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE\Subs\example-video.s01e01-1080p.sub
```
#### After:
```
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE.mkv
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE.eng.idx
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE.eng.sub
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE.deu.idx
main_folder\Video.S01E01.German.DL.1080p-EXAMPLE.deu.sub
```
