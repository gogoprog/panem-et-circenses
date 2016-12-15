package server;

import js.node.socketio.*;

class Main
{
    static public function main()
    {
        trace("Panem et Circenses");

        var server = new Server();

        server.listen(8000);

        new Application(server).run();
    }
}
