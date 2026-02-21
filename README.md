# Macohi (Profile)

Hi lol, this being my profile thing was unintentional lmao

# Macohi (Haxe thing)

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

## Libraries

These are required

```xml
<haxelib name="flixel" />
<haxelib name="flixel-addons" />
<haxelib name="flixel-ui" />
<haxelib name="flixel-animate" />

<haxelib name="newgrounds" if="ENABLE_NEWGROUNDS"/>
<haxelib name="discord_rpc" if="ENABLE_DISCORDRPC" />

<haxelib name="jsonpath" />
<haxelib name="jsonpatch" />
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

## Crash handler

Add this to your Project so the crash handler works

```xml
<define name="CRASH_HANDLER" if="desktop" />

<haxedef name="HXCPP_CHECK_POINTER" if="CRASH_HANDLER" />
<haxedef name="HXCPP_STACK_LINE" if="CRASH_HANDLER" />
<haxedef name="HXCPP_STACK_TRACE" if="CRASH_HANDLER" />
```

## Newgrounds

Build your game with `-DENABLE_NEWGROUNDS` for newgrounds shit

Or you can add this:

```xml
<define name="ENABLE_NEWGROUNDS"/>
```

and compile to html5

## Include assets

Do this

```xml
<assets path="source/macohi/assets" rename="assets"/>
```

and u'll get the assets in here
