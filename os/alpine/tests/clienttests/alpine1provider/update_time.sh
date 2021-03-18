#!/bin/sh

while true; do
	t1="$(date)"
	jq " .time = \"$t1\" " /home/ah/tests/clienttests/alpine1provider/time >  /home/ah/tests/clienttests/alpine1provider/t
	jq " . "  /home/ah/tests/clienttests/alpine1provider/t >  /home/ah/tests/clienttests/alpine1provider/time

	sleep 10
done
