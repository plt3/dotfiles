#!/bin/bash

# function to scp relevant project files (as listed in the submit section in the
# Makefile to a new directory in cs-class)

# this was the first, more complicated try until I realized that simple is better
# cscp () {
#     csclass="plt15@class-1.cs.georgetown.edu"
#
#     dirName="project_"$(date '+%-m_%-d_%-y')
#     dirCreate="mkdir $dirName"
#     submitLine=$(grep -n "submit:" Makefile | cut -f 1 -d :)
#     filesLine=$(($submitLine + 2))
#     filesStr=$(sed "${filesLine}q;d" Makefile | xargs)
#
#     if echo $filesStr | grep -q "^zip submit.zip"
#     then
#         filesArr=($filesStr)
#         ssh $csclass $dirCreate &> /dev/null
#         scp "${filesArr[@]:2}" *.dat $csclass:~/$dirName/
#     else
#         echo "$filesStr in Makefile doesn't start with \"zip submit.zip\", aborting..."
#     fi
# }

# this just scp's all files from the directory, much simpler
cscp () {
    csclass="plt15@class-1.cs.georgetown.edu"

    dirName="project_"$(date '+%-m_%-d_%-y')
    dirCreate="mkdir $dirName"

    make clean
    ssh $csclass $dirCreate &> /dev/null
    # scp !(*.pdf|*.zip) $csclass:~/$dirName/
    scp !(*.pdf) $csclass:~/$dirName/
}
