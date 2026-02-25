# Macohi (All Mine)

Theres more ive made here then stolen

## Command shit

### Install

Go to source : `cd source`

Add this : `git submodule add -b all-mine https://github.com/macohi/macohi-haxe-submod macohi`

Go back From Source : `cd ..`

### General

Update : `git submodule update --init --recursive`

## Other ways of using

Just fukin download the zip and drop it in your haxeflixel project lol

## Libraries

These are required

```xml
<haxelib name="flixel" />
```

# Other shit

## General Project Recommendation

This speeds up compilin

```xml
<haxeflag name="--dce full" unless="debug"/>
```

## I'm getting errors about missing classes!

If you're just editing this manually to add your own shit and it's not detecting your haxelib shit thats cause this isn't a proper haxeflixel project and your not in one probably so run `.\install.bat` and it'll be fine cause you have the libs and theres `main.hxml` which tells whatever ur using "use these libs bruv"

# Things

## Include assets

Do this

```xml
<assets path="source/macohi/allmine/assets" rename="assets"/>
```

and u'll get the assets in here

## FlxBasic ni_ID

```xml
<haxeflag name="--macro" value="addMetadata('@:build(macohi.ul.macros.FlxBasicStringID.buildFlxBasic())', 'flixel.FlxBasic')" />
```
