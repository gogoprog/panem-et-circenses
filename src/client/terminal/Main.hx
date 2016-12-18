package client.terminal;

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
            });
    }
}
