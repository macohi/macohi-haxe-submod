package macohi.backend.api;

#if ENABLE_DISCORDRPC
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;
import sys.thread.Thread;
#end

using macohi.util.StringUtil;

/**
	manager for the discord client stuff

	alot of code yoinked from
	https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/api/discord/DiscordClient.hx
	...
**/
class DiscordClient
{
	public static var CLIENT_ID:Null<String> = null;

	#if ENABLE_DISCORDRPC
	static var handlers:DiscordEventHandlers;
	#end

	/**
	 * @returns `false` if the client ID is invalid.
	 */
	static function hasValidCredentials():Bool
	{
		return !CLIENT_ID.isBlankStr();
	}

	public static function init()
	{
		#if ENABLE_DISCORDRPC
		if (!hasValidCredentials())
		{
			trace(' [DISCORD] Invalid Credentials');
			return;
		}

		trace(' [DISCORD] Initalizing Discord Handler');

		handlers = new DiscordEventHandlers();

		handlers.ready = cpp.Function.fromStaticFunction(onReady);
		handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		handlers.errored = cpp.Function.fromStaticFunction(onError);

		trace(' [DISCORD] Initalizing Discord Client');
		Discord.Initialize(CLIENT_ID, cpp.RawPointer.addressOf(handlers), false, "");

		createDaemon();

		setPresence({
			state: 'Hello World'
		});
		#end
	}

	public static var LARGE_IMAGE_TEXT:String = '';

	#if ENABLE_DISCORDRPC
	var daemon:Null<Thread> = null;

	static function createDaemon():Void
	{
		daemon = Thread.create(doDaemonWork);
	}

	public static function setPresence(params:DiscordClientPresenceParams, ?postMakePresense:DiscordRichPresence->Void):Void
	{
		var presence:DiscordRichPresence = new DiscordRichPresence();

		// Presence should always be playing the game.
		presence.type = DiscordActivityType_Playing;

		// Text when hovering over the large image. We just leave this as the game name.
		presence.largeImageText = LARGE_IMAGE_TEXT;

		// State should be generally what the person is doing, like "In the Menus" or "Pico (Pico Mix) [Freeplay Hard]"
		presence.state = cast(params.state, Null<String>) ?? "";
		// Details should be what the person is specifically doing, including stuff like timestamps (maybe something like "03:24 elapsed").
		presence.details = cast(params.details, Null<String>) ?? "";

		// The large image displaying what the user is doing.
		// This should probably be album art.
		// IMPORTANT NOTE: This can be an asset key uploaded to Discord's developer panel OR any URL you like.
		presence.largeImageKey = cast(params.largeImageKey, Null<String>) ?? '';

		// TODO: Make this use the song's album art.
		// presence.largeImageKey = "icon";
		// presence.largeImageKey = "https://f4.bcbits.com/img/a0746694746_16.jpg";

		// The small inset image for what the user is doing.
		// This can be the opponent's health icon?
		// NOTE: Like largeImageKey, this can be a URL, or an asset key.
		presence.smallImageKey = cast(params.smallImageKey, Null<String>) ?? '';

		// NOTE: In previous versions, this showed as "Elapsed", but now shows as playtime and doesn't look good
		// presence.startTimestamp = time - 10;
		// presence.endTimestamp = time + 30;

		if (postMakePresense != null)
			postMakePresense(presence);

		// final button1:DiscordButton = new DiscordButton();
		// button1.label = "Play on Web";
		// button1.url = MegaVars.DISCORDRPC_BUTTON1;
		// presence.buttons[0] = button1;

		// final button2:DiscordButton = new DiscordButton();
		// button2.label = "Download";
		// button2.url = MegaVars.URL_ITCH;
		// presence.buttons[1] = button2;

		Discord.UpdatePresence(cpp.RawConstPointer.addressOf(presence));
	}

	static function doDaemonWork():Void
	{
		while (true)
		{
			#if DISCORD_DISABLE_IO_THREAD
			Discord.updateConnection();
			#end

			Discord.RunCallbacks();
			Sys.sleep(2);
		}
	}

	public static function shutdown():Void
	{
		trace(' [DISCORD] Shutting down...');

		Discord.Shutdown();
	}

	// TODO: WHAT THE FUCK get this pointer bullfuckery out of here
	private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void
	{
		trace(' [DISCORD] Client has connected!');

		final username:String = request[0].username;
		final globalName:String = request[0].username;
		final discriminator:Null<Int> = Std.parseInt(request[0].discriminator);

		if (discriminator != null && discriminator != 0)
		{
			trace(' [DISCORD] User: ${username}#${discriminator} (${globalName})');
		}
		else
		{
			trace(' [DISCORD] User: @${username} (${globalName})');
		}
	}

	private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void
	{
		trace(' [DISCORD] Client has disconnected! ($errorCode) "${cast (message, String)}"');
	}

	private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void
	{
		trace(' [DISCORD] Client has received an error! ($errorCode) "${cast (message, String)}"');
	}
	#else
	public static function setPresence(params:DiscordClientPresenceParams, ?postMakePresense:Dynamic->Void):Void {}
	#end
}

typedef DiscordClientPresenceParams =
{
	/**
	 * The first row of text below the game title.
	 */
	var state:String;

	/**
	 * The second row of text below the game title.
	 * Use `null` to display no text.
	 */
	var ?details:Null<String>;

	/**
	 * A large, 4-row high image to the left of the content.
	 */
	var ?largeImageKey:String;

	/**
	 * A small, inset image to the bottom right of `largeImageKey`.
	 */
	var ?smallImageKey:String;
}
