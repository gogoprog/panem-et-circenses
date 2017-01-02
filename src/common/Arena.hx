package common;

import haxe.Timer;

class Arena
{
    public var heroes:Array<Hero> = new Array<Hero>();
    public var gamblers:Array<Gambler> = new Array<Gambler>();
    public var timeFactor:Float = 1.0;
    public var battleCount = 0;

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
        var context = new BattleContext();

        context.eventCallback = eventCallback;
        battle.start(timeFactor, context, function() {
            giveRewards(battle);
            Timer.delay(startBattle, Std.int(10000 / timeFactor));
            battleCount++;
        });
    }

    public function giveRewards(battle:Battle)
    {
        var points = [25, 18, 15, 12, 10, 8, 6, 4, 2, 1];

        for(i in 0...points.length)
        {
            if(i >= battle.ranking.length)
            {
                break;
            }

            battle.ranking[i].gainXp(Std.int(points[i] * (1.0 + battleCount / 10.0)));
        }
    }
}
