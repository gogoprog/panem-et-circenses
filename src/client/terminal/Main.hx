package client.terminal;

import js.node.Readline;
import js.node.readline.Interface;
import js.Node.process;
import js.Node.console;
import js.node.socketio.*;
import common.Log;
import common.LogColor;
import common.Battle;
import common.Hero;
import haxe.Unserializer;

class Main
{
    static private var rli:Interface;
    static private var client:Client;
    static private var arenas:Array<String>;
    static private var heroes:Array<Hero>;

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
                        client.emit("login", { name:value });
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
                    function(index, result)
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
            }
        );

        client.on(
            "battleUpdate",
            function(data)
            {
                var unserializer = new Unserializer(data);
                var battle:Battle = unserializer.unserialize();

                Log.clear();
                trace(data.length);
                battle.logHeroes();
            }
            );

        client.on(
            "preBattle",
            function(data)
            {
                var unserializer = new Unserializer(data);
                heroes = unserializer.unserialize();

                Log.clear();

                var heroesName = [for (hero in heroes) hero.name];

                choiceMaker(
                    heroesName,
                    "Bet on hero?",
                    "Select hero: ",
                    function(index, result)
                    {
                        client.emit("bet", { heroIndex: index, amount: 100 });
                    }
                    );
            }
            );

        trace("Connecting...");
    }

    private static function processCommand()
    {
        for(h in 0...heroes.length)
        {
            trace(h + ". " + heroes[h].name);
        }

        rli.question(
            "> ",
            function(value:String)
            {
                processCommand();
            }
        );
    }

    private static function choiceMaker(choices:Array<String>, title:String, prompt:String, resultCallback:Int->String->Void)
    {
        trace(title);

        for(i in 0...choices.length)
        {
            Log.color(LogColor.Yellow);
            Log.write("" + i);
            Log.color(LogColor.LightGray);
            Log.write(" : " + choices[i]);
            Log.flush();
        }

        rli.question(
            prompt,
            function(value:String)
            {
                var numberValue = Std.parseInt(value);

                if(numberValue != null && numberValue >= 0 && numberValue < choices.length)
                {
                    resultCallback(numberValue, choices[numberValue]);
                }
                else
                {
                    choiceMaker(choices, title, prompt, resultCallback);
                }
            }
        );
    }
}
