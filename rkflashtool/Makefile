all: rkflashtool

rkflashtool: rkflashtool.c
	gcc -o rkflashtool rkflashtool.c -lusb-1.0 -O2 -W -Wall -s

param:
	sudo ./rkflashtool r 0x0000 0x2000 > /tmp/parm
