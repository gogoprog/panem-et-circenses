package server;

import js.node.socketio.*;
import common.Arena;
import common.Gambler;
import haxe.Serializer;

class Application
{
    private var server:Server;
    private var roomArenaMap = new Map<String, Arena>();

    //private var gamblerSocketMap = new Map<Gambler, Socket>();
    //private var socketGamblerMap = new Map<Socket, Gambler>();

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
                socket.on(
                    'login',
                    function(data)
                    {
                        var gambler = new Gambler(data.name);

                        //gamblerSocketMap[gambler] = socket;
                        //socketGamblerMap[socket] = gambler;

                        socket.emit("arenas", [for (k in roomArenaMap.keys()) k]);

                        socket.on(
                            'joinArena',
                            function(data)
                            {
                                var arena = roomArenaMap[data.name];

                                trace(gambler.name + " joined " + data.name);

                                socket.join(data.name);
                                socket.emit("welcome", {name:data.name});

                                arena.gamblers.push(gambler);

                                socket.on(
                                    'bet',
                                    function(data)
                                    {
                                        trace(data);
                                    }
                                );
                            }
                        );


                    }
                );

                socket.emit("connected");
            }
        );

        createRandomArenas(10);
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
            arena.createRandomHeroes(8);
            roomArenaMap[name] = arena;

            arena.eventCallback = function(eventName, data)
            {
                var serializer = new Serializer();
                serializer.serialize(data);
                server.to(name).emit(eventName, serializer.toString());
            };
        }
    }
}
