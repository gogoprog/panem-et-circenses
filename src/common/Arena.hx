package common;

import haxe.Timer;

class Arena
{
    public var heroes:Array<Hero> = new Array<Hero>();
    public var battles:Array<Battle> = new Array<Battle>();
    public var gamblers:Array<Gambler> = new Array<Gambler>();

    public var eventCallback:String->Dynamic->Void = null;

    public function new()
    {
    }

    public function createRandomHeroes(total:Int)
    {
        for(i in 0...total)
        {
            var hero = new Hero();

            hero.randomizeStats();
            hero.randomizeName();
            hero.compute();

            heroes.push(hero);
        }
    }

    public function start()
    {
        var battle = new Battle(heroes);

        battle.begin();

        function iter()
        {
            battle.update(1.0);

            //Log.clear();
            //battle.logHeroes();

            if(eventCallback != null)
            {
                eventCallback("battleUpdate", battle);
            }

            if(!battle.isOver())
            {
                Timer.delay(iter, 1000);
            }
        }

        iter();
    }
}
