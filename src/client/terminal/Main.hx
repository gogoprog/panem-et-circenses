package client.terminal;

import js.node.Readline;
import js.node.readline.Interface;
import js.Node.process;
import js.Node.console;
import js.node.socketio.*;

class Main
{
    static private var rli:Interface;
    static private var client:Client;
    static private var arenas:Array<String>;

    static public function main()
    {
        trace("Panem et Circenses - terminal client");

        client = new Client("http://localhost:8000/");
        rli = Readline.createInterface(process.stdin, process.stdout);

        client.on('welcome',
            function (data)
            {
                trace("Connected to the server.");
            }
        );

        client.on('arenas',
            function (data:Array<String>)
            {
                arenas = data;
                arenaSelection();
            }
        );

        client.on('welcome',
            function (data)
            {
                trace("Welcome on " + data.name);

                processCommand();
            }
        );

        rli.question(
            "Enter your nickname : ",
            function(value:String)
            {
                client.emit("login", { nickname:value });
            }
        );
    }

    private static function processCommand()
    {
        rli.question(
            "> ",
            function(value:String)
            {
                processCommand();
            }
        );
    }

    private static function arenaSelection()
    {
        trace("Arena lists:");

        for(i in 0...arenas.length)
        {
            trace("[" + i + "] " + arenas[i]);
        }

        rli.question(
            "Enter which arena : ",
            function(value:String)
            {
                var numberValue = Std.parseInt(value);

                if(numberValue != null && numberValue >= 0 && numberValue < arenas.length)
                {
                    client.emit("joinArena", { name: arenas[numberValue] });
                }
                else
                {
                    arenaSelection();
                }
            }
        );
    }
}
