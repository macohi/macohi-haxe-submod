# Macohi

Bunch o shit I'll prob use in multiple projects

## Command shit

### Install

Go to source : `cd source`

Add this : `git submodule add https://github.com/sphis-sinco/macohi`

Go back From Source : `cd ..`

### General

Update : `git submodule update --init --recursive`

## Other ways of using

Just fukin download the zip and drop it in your haxeflixel project lol

## Notes

### Dates

For the Dates I use an extension : "Write Timestamp" (gieson.writetimestamp) (DOn't really need to but it's smth auto-done for me lmao im usin it)
I have C list set to custom and B custom format to "y-mm-dd" Or just set C list to that lmao.

Originally there WERE timestamps and the my custom format was "y-mm-dd @ HH:MM AA" but I changed my mind,
It broke the `@since` and removing the time from the `@since` manually was gonna be annoying so yeah :D

So yuh

# Other shit

## I'm getting errors about missing classes!

If you're just editing this manually to add your own shit and it's not detecting your haxelib shit thats cause this isn't a proper haxeflixel project and your not in one probably so run `.\install.bat` and it'll be fine cause you have the libs and theres `main.hxml` which tells whatever ur using "use these libs bruv"