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
                trace("Arena lists:");

                for(arena in data)
                {
                    trace("- " + arena);
                }

                rli.question(
                    "Enter which arena : ",
                    function(value:String)
                    {
                        client.emit("joinArena", { name:value });
                    }
                );
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
}
