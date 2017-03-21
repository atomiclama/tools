

# find the source .lua files in the file system and substitute to the output 
MD5_SRC = $(shell find . -type f -name '*.md')
MD5_SUM = $(patsubst %.md, %.md5 , $(MD5_SRC))
MD5_CHK = $(patsubst %.md, %.chk , $(MD5_SRC))


push:
	git push -u origin master

pull:
	git fetch

sync_vid:
	rsync -a --progress /share/adult/*.mkv rsync://tikka/media/films/Adult
	rsync -a --progress /share/kids/*.mkv rsync://tikka/media/films/kids

sync_pic:
	rsync -a --progress ~/Pictures/ rsync://tikka/media pic

sync_all: sync_vid sync_pic


%.md5: %.md
	md5sum "$<" > "$@"

md5_all: $(MD5_SUM)
	
%.chk : %.md5
	@md5sum -c "$<"
	
md5_check: $(MD5_CHK)	
