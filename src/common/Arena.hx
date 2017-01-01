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
        battle.context.eventCallback = eventCallback;
        battle.start(timeFactor);
        battle.onEndCallback = function() {
            Timer.delay(startBattle, Std.int(10000 / timeFactor));
            };
    }
}
