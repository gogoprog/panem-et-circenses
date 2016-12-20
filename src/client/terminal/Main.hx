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

        client.on('welcome',
            function (data)
            {
                trace("Arenas:");
                trace(data);
            }
        );

        var rli = Readline.createInterface(process.stdin, process.stdout);

        rli.question(
            "Enter your nickname : ",
            function(value:String)
            {
                client.emit("login", { nickname:value });
            }
        );
    }
}
