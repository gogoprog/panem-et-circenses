package test;

import common.*;

class Main
{
    static public function main()
    {
        trace("Panem et Circenses - test");

        var arena = new Arena();
        arena.timeFactor = 10;
        arena.createRandomHeroes(10);

        arena.eventCallback = function(eventName, data)
        {
        	var battle:Battle = data;
            Log.clear();
            battle.logHeroes();

            if(battle.isOver())
            {
            	Log.write("Winners: ");
            	for(hero in battle.survivors)
            	{
            		Log.write(hero.name);
            		Log.write(", ");
            	}

            	Log.flush();
            }
        };

        arena.start();
    }
}
