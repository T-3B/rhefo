#!/bin/bash

archs=(x86-64 aarch64)

for i in ${archs[@]}
do	{
		sed /^#EOF#$/q rhefo
		eval find addins -mindepth 1 ! -name README.md $(printf "! -name '*_%s' " ${archs[@]/$i}) -printf '%P\\n' | tar c -b1 -C./addins/ --xform=s/_$i$// -T- | base64 -w600
	} >rhefo_$i; chmod +x rhefo_$i
done
