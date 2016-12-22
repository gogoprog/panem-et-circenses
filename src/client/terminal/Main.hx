package client.terminal;

import js.node.Readline;
import js.node.readline.Interface;
import js.Node.process;
import js.Node.console;
import js.node.socketio.*;

class Main
{
    static public function main()
    {
        trace("Panem et Circenses - terminal client");

        var client = new Client("http://localhost:8000/");
        var rli = Readline.createInterface(process.stdin, process.stdout);

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

        rli.question(
            "Enter your nickname : ",
            function(value:String)
            {
                client.emit("login", { nickname:value });
            }
        );
    }
}
