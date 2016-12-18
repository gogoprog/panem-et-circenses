package server;

import js.node.socketio.*;
import common.*;

class Application
{
    private var server:Server;
    private var arenasMap = new Map<String, Arena>();

    public function new(server:Server)
    {
        this.server = server;
        setup();
    }

    public function setup()
    {
        server.on(
            'connection',
            function(socket:Socket)
            {
                socket.emit("welcome", [for (k in arenasMap.keys()) k]);
            }
        );

        createRandomArenas(1);
    }

    public function run()
    {
        for(arena in arenasMap)
        {
            arena.start();
        }
    }

    private function createRandomArenas(count:Int)
    {
        for(i in 0...count)
        {
            var name = "name" + i;
            var arena = new Arena();
            arena.createRandomHeroes(40);
            arenasMap[name] = arena;
        }
    }
}
