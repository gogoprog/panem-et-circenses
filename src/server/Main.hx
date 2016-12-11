package server;
import common.*;

class Main
{
    static public function main()
    {
        trace("Panem et Circenses");

        var arena = new Arena();

        arena.createRandomHeroes(4);

        js.Lib.debug();
        arena.start();
    }
}
