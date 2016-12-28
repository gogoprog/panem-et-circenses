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

        client.on(
            'connected',
            function (data)
            {
                trace("Connected.");

                rli.question(
                    "Enter your nickname : ",
                    function(value:String)
                    {
                        client.emit("login", { nickname:value });
                    }
                );
            }
        );

        client.on(
            'arenas',
            function (data:Array<String>)
            {
                arenas = data;

                choiceMaker(
                    arenas,
                    "Arenas list :",
                    "Enter arena number : ",
                    function(result)
                    {
                        client.emit("joinArena", { name: result });
                    }
                    );
            }
        );

        client.on(
            'welcome',
            function (data)
            {
                trace("Welcome on " + data.name);

                processCommand();
            }
        );

        trace("Connecting...");
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

    private static function choiceMaker(choices:Array<String>, title:String, prompt:String, resultCallback:String->Void)
    {
        trace(title);

        for(i in 0...choices.length)
        {
            trace("[" + i + "] " + choices[i]);
        }

        rli.question(
            prompt,
            function(value:String)
            {
                var numberValue = Std.parseInt(value);

                if(numberValue != null && numberValue >= 0 && numberValue < choices.length)
                {
                    resultCallback(choices[numberValue]);
                }
                else
                {
                    choiceMaker(choices, title, prompt, resultCallback);
                }
            }
        );
    }
}
