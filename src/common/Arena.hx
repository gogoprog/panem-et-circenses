package common;

import haxe.Timer;

class Arena
{
    public var heroes:Array<Hero> = new Array<Hero>();
    public var battles:Array<Battle> = new Array<Battle>();
    public var gamblers:Array<Gambler> = new Array<Gambler>();
    public var timeFactor:Float = 1.0;

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
        startBattle();
    }

    public function startBattle()
    {
        var battle = new Battle(heroes);
        var targetMap = new Map<Hero, Hero>();

        battle.begin();

        function iter()
        {
            battle.update(1.0, targetMap);

            if(eventCallback != null)
            {
                eventCallback("battleUpdate", battle);
            }

            if(!battle.isOver())
            {
                Timer.delay(iter, Std.int(1000 / timeFactor));
            }
            else
            {

                if(eventCallback != null)
                {
                    eventCallback("battleEnd", battle);
                }

                Timer.delay(startBattle, Std.int(10000 / timeFactor));
            }
        }

        iter();
    }
}
