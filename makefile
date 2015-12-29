

all:
	zip -r game.zip conf.lua main.lua menu.lua fluidwar.lua

exec:
	love game.zip
