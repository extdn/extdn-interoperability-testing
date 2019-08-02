#!/bin/bash
currentDir=`pwd`
cd $currentDir/../../../

touch jisse2

test -f ./bin/magento || (echo "Not in a Magento environment"; exit)

# Run scripts
for i in $currentDir/scripts/* ; do
    bash $i
done

# End
