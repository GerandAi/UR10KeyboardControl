@echo off
setlocal enabledelayedexpansion

::if defined i (echo i is being used) else (echo i is SAFE to use)
::if defined c (echo c is being used) else (echo c is SAFE to use)
::if defined b (echo b is being used) else (echo b is SAFE to use)
::if defined a (echo a is being used) else (echo a is SAFE to use)
::if defined x (echo x is being used) else (echo x is SAFE to use)
::if defined y (echo y is being used) else (echo y is SAFE to use)
::if defined z (echo z is being used) else (echo z is SAFE to use)
::if defined pitch (echo pitch is being used) else (echo pitch is SAFE to use)
::if defined roll (echo roll is being used) else (echo roll is SAFE to use)
::if defined yaw (echo yaw is being used) else (echo yaw is SAFE to use)


set /a d=10 && set /a a=1

:clear
set /a x=0 && set /a y=0 && set /a z=0
set /a pitch=0 && set /a roll=0 && set /a yaw=0
echo cleared previously stored movement

:reference
echo reterned to reference point
echo 0.0>coord.txt&&echo 0.001>>coord.txt&& echo 0.0>>coord.txt
echo 0.0>>coord.txt&& echo 0.0>>coord.txt&& echo 0.0>>coord.txt

for /L %%i in (1,1,100) do (
	if defined b (set /a b=!b!+0) else (set /a b=%d%)

	cls
	if defined c (echo current relative pose vector: && type coord.txt) else (type log.txt)
	if "!c!" equ "i" type log.txt
	if "!c!" equ "r" echo reterned to reference point
	if "!c!" equ "c" echo cleared previously stored movement
	if !c! == 4 echo moving left
	if !c! == 6 echo moving right
	if !c! == 8 echo moving up
	if !c! == 2 echo moving down
	if "!c!" equ "w" echo retracting
	if "!c!" equ "s" echo extending
	if "!c!" == "a" echo yaw left
	if "!c!" == "d" echo yaw right
	if "!c!" == "q" echo roll left
	if "!c!" == "e" echo roll right
	if "!c!" == "p" echo pitch up
	if "!c!" == "l" echo pitch down

	set c=void
	set /p c=direction: 

	if !c! == 4 set /a x+=!b! && echo moving left
	if !c! == 6 set /a x-=!b! && echo moving right
	if !c! == 8 set /a z+=!b!  && echo moving up
	if !c! == 2 set /a z-=!b!  && echo moving down
	if "!c!" equ "c" goto clear
	if !c! equ 0 goto finish
	if "!c!" equ "r" goto reference
	if "!c!" equ "w" set /a y+=!b! && echo retract
	if "!c!" equ "s" set /a y-=!b! && echo extend
	if "!c!" == "a" set /a yaw+=%a% && echo yaw left
	if "!c!" == "d" set /a yaw-=%a% && echo yaw right
	if "!c!" == "q" set /a roll+=%a% && echo roll left
	if "!c!" == "e" set /a roll-=%a% && echo roll right
	if "!c!" == "p" set /a pitch+=%a% && echo pitch up
	if "!c!" == "l" set /a pitch-=%a% && echo pitch down
	if "!c!" equ "5" set /p b=step length: 
	if "!c!" equ "i" type log.txt

	::sendpos
	if !z! gtr 700 set /a z=700
	echo !x!>coord.txt&& echo !y!>>coord.txt&& echo !z!>>coord.txt
	if !pitch! geq 0 (echo 0.!pitch!>>coord.txt) else (set /a modpitch=-!pitch! && echo -0.!modpitch!>>coord.txt)
	if !roll! geq 0 (echo 0.!roll!>>coord.txt) else (set /a modroll=-!roll! && echo -0.!modroll!>>coord.txt)
	if !yaw! geq 0 (echo 0.!yaw!>>coord.txt) else (set /a modyaw=-!yaw! && echo -0.!modyaw!>>coord.txt)
)
:finish
echo finished
echo 0.0>coord.txt&& echo 0.0>>coord.txt&& echo 0.0>>coord.txt
echo 0.0>>coord.txt&&echo 0.0>>coord.txt&& echo 0.0>>coord.txt
