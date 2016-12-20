package server;

import js.node.socketio.*;
import common.*;

class Application
{
    private var server:Server;
    private var roomArenaMap = new Map<String, Arena>();

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
                socket.emit("welcome", [for (k in roomArenaMap.keys()) k]);

                socket.on(
                    'login',
                    function(data)
                    {
                        trace(data);
                    }
                );
            }
        );

        createRandomArenas(1);
    }

    public function run()
    {
        for(arena in roomArenaMap)
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
            roomArenaMap[name] = arena;
        }
    }
}
